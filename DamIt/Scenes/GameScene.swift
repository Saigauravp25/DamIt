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
//    var restartNode = Restart()
    var level: Level?
    let putDownSound = SKAction.playSoundFileNamed("putDown.wav", waitForCompletion: false)
    let floodSound = SKAction.playSoundFileNamed("flood.wav", waitForCompletion: false)
    var ref: DatabaseReference!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.view?.showsPhysics = false
        self.backgroundColor = UIColor(hex: 0x006994) //0xB3E5FC
        self.setupNodes()
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
        let levelComplete = self.level?.checkLevelComplete()
        //core data update to set value to true
        if levelComplete! {
            //Placeholder for now. Do action when level is complete.
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
                    let level = Int(userLevelData.substring(with: distance+1..<userLevelData.count - 1))!
                    let chars = Array(userLevelData)
                    var newUserLevel = userLevelData.substring(to: distance + 1)
                    let updatedLevel = String(level + 1)
                    // Recreating new string to update in database
                    newUserLevel = newUserLevel + updatedLevel + "]"
                    // Writing in database
                    self.ref.child("users").child(userID!).setValue(["levelPack": newUserLevel])
                }

              // ...
              }) { (error) in
                print(error.localizedDescription)
            }
        }
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
