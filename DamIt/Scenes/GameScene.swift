//
//  GameScene.swift
//  SpriteKitBlocks
//
//  Created by Saigaurav Purushothaman on 10/3/20.
//

import SpriteKit
import GameplayKit
import CoreData
import Firebase

let blockBitMask = UInt32(1)
let beaverBitMask = UInt32(2)
let victoryTextBitMask = UInt32(4)

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    public var levelEncoding: String = ""
    var isComplete = false
    var sky: Sky!
    var groundNode = Ground()
    var mountainNode = Mountain()
    var oceanNode = Ocean()
    var logo = Logo()
    var victoryText = Victory()
    var nextLevelButton: UIButton!
    var helpText: SKLabelNode!
    var isTutorial: Bool!
//    var restartNode = Restart()
    var level: Level?
    var movementCheckpoint = false
    var logCheckpoint = false
    var pickupCheckpoint = false
    var holdingLogCheckpoint = false
    var buildDamCheckpoint = false
    var warningCheckpoint = false
    let putDownSound = !gameSettings.settings[0] ? SKAction.playSoundFileNamed("noSound.mp3", waitForCompletion: false) : SKAction.playSoundFileNamed("putDown.wav", waitForCompletion: false)
    let floodSound = !gameSettings.settings[0] ? SKAction.playSoundFileNamed("noSound.mp3", waitForCompletion: false) : SKAction.playSoundFileNamed("flood.wav", waitForCompletion: false)
    var ref: DatabaseReference!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.view?.showsPhysics = false
        self.backgroundColor = UIColor(hex: 0x006994)//0xB3E5FC
        self.setupNodes()
        if(levelEncoding.substring(to: 4) == "0000"){
            isTutorial = true
        }
        else{
            isTutorial = false
        }
        if(isTutorial){
            helpText = SKLabelNode(fontNamed: "Chalkduster")
            helpText.zPosition = 6.0
            helpText.numberOfLines = 3
            helpText.preferredMaxLayoutWidth = frame.maxX
            helpText.horizontalAlignmentMode = .center
            helpText.verticalAlignmentMode = .center
            setText(text: "Welcome to Dam It! The goal of the game is to create a flush dam using the availabe log blocks. Swipe Left and Right in order to move the Beaver. Use this to head over to the logs")
            //helpText.text = "Welcome to Dam It! The goal of the game is to create a flush dam using the availabe log blocks. Swipe Left and Right in order to move the Beaver. Use this to head over to the logs"
            helpText.position = CGPoint(x: frame.midX, y: frame.midY / 2)
            addChild(helpText)
        }
        level = Level(levelData: self.getLevelData(levelData: levelEncoding), for: self)
        addSwipe()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        victoryText.run(self.putDownSound)
    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.view!.addGestureRecognizer(gesture)// self.view
        }
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if self.isPaused || self.isComplete {
            return
        }
        let direction = sender.direction
        switch direction {
            case .right:
                _ = self.level?.movePlayer(direction: .right)
                print("Gesture direction: Right")
            case .left:
                _ = self.level?.movePlayer(direction: .left)
                print("Gesture direction: Left")
            case .up:
                print("Gesture direction: Up")
            case .down:
                _ = self.level?.playerToggleCarryLog()
                print("Gesture direction: Down")
            default:
                print("Unrecognized Gesture Direction")
        }
        if(isTutorial){
            if(self.level?.player.y == 10 && (self.level?.player.x)! >= 5){
                setText(text: "Click the restart button to start over")
            }
            if(self.level?.player.y == 2 && logCheckpoint == false){
                logCheckpoint = true
                setText(text: "You can scale 1 block high heights. Swipe left in order to jump up on top of the log")
            }
            if(self.level?.player.y == 1 && pickupCheckpoint == false){
                pickupCheckpoint = true
                setText(text: "Swipe down in order to pick up log blocks directly in front of you")
            }
            if((self.level?.player.hasLog)! && pickupCheckpoint && holdingLogCheckpoint == false){
                holdingLogCheckpoint = true
                setText(text: "Head back over to the hole in order to start building the dam")
            }
            if((self.level?.player.hasLog)! && self.level?.player.y == 9 && buildDamCheckpoint == false){
                buildDamCheckpoint = true
                setText(text: "Swipe down to place down logs in the direction you are facing. You can throw down logs from any height")
            }
            if(self.level?.player.hasLog == false && buildDamCheckpoint && warningCheckpoint == false){
                warningCheckpoint = true
                setText(text: "Beavers can jump down from any height so be careful not to get yourself stuck. You'll have to restart the level if that happens. Now keep moving logs in order to finish building the dam")
            }
        }
        let levelComplete = self.level?.checkLevelComplete()
        //core data update to set value to true
        if levelComplete! {
            //Placeholder for now. Do action when level is complete.
            if(isTutorial){
                setText(text: "Congrats, you are ready to play Dam It!")
            }
            self.isComplete = true
            self.victoryText.drop()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.nextLevelButton.isHidden = false
            }
            ref = Database.database().reference()
            var userID = Auth.auth().currentUser?.email
            // reformatting the email again to query the database
            userID = userID!.replacingOccurrences(of: "@", with: ",")
            userID = userID!.replacingOccurrences(of: ".", with: ",")
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              let value = snapshot.value as? NSDictionary
                let userLevelData = value?["levelPack"] as? String ?? ""
                if let index = userLevelData.firstIndex(of: ":") {
                    // Need to break up the levelpack string so that we can update with new level, since one has just been beaten
                    let distance = userLevelData.distance(from: userLevelData.startIndex, to: index)
                    var levelPack = Int(userLevelData.substring(with: 1 ..< distance))!
                    let level = Int(userLevelData.substring(with: distance+1..<userLevelData.count - 1))!
                    let chars = Array(userLevelData)
                    if(level + 1 > 10){
                        levelPack += 1
                    }
                    let updatedLevel = String((level + 1)%10)
                    let updatedUserLevelInfo = "[" + String(levelPack) + ":" + updatedLevel + "]"
                    // Writing in database
                    self.ref.child("users").child(userID!).setValue(["levelPack": updatedUserLevelInfo])
                }

              // ...
              }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func setText(text: String){
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40)], range: range)
        helpText.attributedText = attrString
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            let touchedNode = atPoint(location)
//            if touchedNode.name == "Restart" {
//                self.setupNodes()
//                self.oceanNode.flood()
//                touchedNode.run(floodSound)
//                self.logo.show()
//                self.restartNode.hide()
////                self.victoryText.hide()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
//                    self.logo.hide()
//                    self.setupNodes()
//                    self.oceanNode.unflood()
//                    self.restartNode.show()
//                    self.level = Level(levelData: self.getLevelData(), for: self)
//                }
//            }
//        }
//    }
}

extension GameScene {
        
    func setupNodes() {
        self.nextLevelButton.isHidden = true
        self.isComplete = false
        self.removeAllChildren()
        self.sky = Sky(for: self)
        self.sky.createStarLayers()
        self.groundNode.setupGround(self)
        self.mountainNode.setupMountains(self)
        self.oceanNode.setupOcean(self)
//        self.restartNode.setupRetryButton(self)
        self.logo.setupLogo(self)
        self.victoryText.setupText(self)
    }
    
    func setupTutorial(){
        helpText = SKLabelNode(fontNamed: "Chalkduster")
        helpText.zPosition = 6.0
        helpText.numberOfLines = 3
        helpText.preferredMaxLayoutWidth = frame.maxX
        helpText.horizontalAlignmentMode = .center
        helpText.verticalAlignmentMode = .center
        setText(text: "Welcome to Dam It! The goal of the game is to create a flush dam using the availabe log blocks. Swipe Left and Right in order to move the Beaver. Use this to head over to the logs")
        helpText.position = CGPoint(x: frame.midX, y: frame.midY / 2)
        addChild(helpText)
        self.movementCheckpoint = false
        self.logCheckpoint = false
        self.pickupCheckpoint = false
        self.holdingLogCheckpoint = false
        self.buildDamCheckpoint = false
        self.warningCheckpoint = false
    }
    
    func getLevelData(levelData: String) -> LevelDataFormat {
        
        self.levelEncoding = levelData
        var levelDecoder: LevelDataDecoder!
        
        //Store the Level Encoding String in CoreData
//        let level1Encoding = "01011004RLLLLLAAAAAALLAALAAARRBAAAAALLAALLLARRLL"
//        levelDecoder = LevelDataDecoder(for: level1Encoding)
//        let level1Data = levelDecoder.getLevelDataFromEncoding()
//        
//        let level2Encoding = "01021604LLLLRAAARRLAAAAARRAAAAAALAAALLLARRAARBAARRLLAAAAAAAARRLARLLLRLLL"
//        levelDecoder = LevelDataDecoder(for: level2Encoding)
//        let level2Data = levelDecoder.getLevelDataFromEncoding()
//        
//        let level3Encoding = "01031004RLLARLAALAAARAAARRLARRBARLLAAAAARRAALLLA"
//        levelDecoder = LevelDataDecoder(for: level3Encoding)
//        let level3Data = levelDecoder.getLevelDataFromEncoding()
        
        levelDecoder = LevelDataDecoder(for: levelData)
        let data = levelDecoder.getLevelDataFromEncoding()
        return data
    }
}
