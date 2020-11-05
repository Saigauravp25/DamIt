//
//  GameViewController.swift
//  SpriteKitBlocks
//
//  Created by Saigaurav Purushothaman on 10/3/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
   
    
    var levelEncoding: String!
    var levelData: [String]!
    var currentLevel: Int!
    var currentPack: Int!
    var skView: SKView!
    var isTutorial = false
    
    var delegate: UIViewController!
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    
    @IBOutlet weak var nextLevelButtonOutlet: UIButton!
    
    @IBAction func nextLevelButton(_ sender: UIButton) {
        
        if(isTutorial){
            self.dismiss(animated: true, completion: nil)
        }
        else{
            if(currentLevel == 9){
                currentPack += 1
            }
            currentLevel = (currentLevel + 1) % 10 //loop in this level pack until future level packs are made
            let otherVC = delegate as! LevelSelectViewController
            otherVC.updateLevel(levelNumber: currentLevel)
            levelEncoding = levelData[currentLevel]
            (skView.scene as! GameScene).levelEncoding = levelEncoding
            nextLevelButtonOutlet.isHidden = true
            skView.presentScene(skView.scene)
                skView.presentScene(skView.scene)
        }
    }
    
    
    @IBAction func pauseButton(_ sender: UIButton) {
        self.skView.isPaused = !self.skView.isPaused
        let image = self.skView.isPaused ? UIImage(systemName: "play.circle.fill") : UIImage(systemName: "pause.circle.fill")
        pauseButtonOutlet.setBackgroundImage(image, for: .normal)
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        nextLevelButtonOutlet.isHidden = true
        var xForce = 50.0
        var yForce = 50.0
        let gameScene = self.skView.scene as! GameScene
//        gameScene.victoryText.hide()
        gameScene.oceanNode.flood()
        gameScene.enumerateChildNodes(withName: "Log") {
            (node, stop) in
            let block = node as! Block
            block.activateGravity()
            xForce *= (Bool.random() ? 1 : -1)
            yForce *= (Bool.random() ? 1 : -1)
            block.physicsBody?.applyImpulse(CGVector(dx: xForce, dy: yForce))
        }
        gameScene.enumerateChildNodes(withName: "Rock") {
            (node, stop) in
            let block = node as! Block
            block.activateGravity()
            xForce *= (Bool.random() ? 1 : -1)
            yForce *= (Bool.random() ? 1 : -1)
            block.physicsBody?.applyImpulse(CGVector(dx: xForce, dy: yForce))
        }
        gameScene.enumerateChildNodes(withName: "Beaver") {
            (node, stop) in
            let block = node as! Block
            block.activateGravity()
            xForce *= (Bool.random() ? 1 : -1)
            yForce *= (Bool.random() ? 1 : -1)
            block.physicsBody?.applyImpulse(CGVector(dx: xForce, dy: yForce))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
//            gameScene.setupNodes()
            gameScene.oceanNode.run(gameScene.floodSound)
            gameScene.logo.show()
    //        gameScene.restartNode.hide()
    //                self.victoryText.hide()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                gameScene.logo.hide()
                gameScene.setupNodes()
                if(self.isTutorial){
                    gameScene.setupTutorial()
                }
                gameScene.oceanNode.unflood()
    //            gameScene.restartNode.show()
                gameScene.level = Level(levelData: gameScene.getLevelData(levelData: gameScene.levelEncoding), for: gameScene)
            }
        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextLevelButtonOutlet.isHidden = true
        //print("LEVEL ENCODING FOR GAME SCENE: \(levelEncoding)")
        let scene = GameScene(size: CGSize(width: 2048.0, height: 1536.0))
        scene.levelEncoding = levelEncoding
        scene.nextLevelButton = self.nextLevelButtonOutlet
        scene.scaleMode = .aspectFill
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        self.skView = skView
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
