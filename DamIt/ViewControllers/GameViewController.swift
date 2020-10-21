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
    var skView: SKView!
    
    @IBOutlet weak var pauseButtonOutlet: UIButton!
    
    @IBAction func pauseButton(_ sender: UIButton) {
        self.skView.isPaused = !self.skView.isPaused
        let image = self.skView.isPaused ? UIImage(systemName: "play.circle.fill") : UIImage(systemName: "pause.circle.fill")
        pauseButtonOutlet.setBackgroundImage(image, for: .normal)
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        let gameScene = self.skView.scene as! GameScene
        gameScene.setupNodes()
        gameScene.oceanNode.flood()
        gameScene.oceanNode.run(gameScene.floodSound)
        gameScene.logo.show()
//        gameScene.restartNode.hide()
//                self.victoryText.hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            gameScene.logo.hide()
            gameScene.setupNodes()
            gameScene.oceanNode.unflood()
//            gameScene.restartNode.show()
            gameScene.level = Level(levelData: gameScene.getLevelData(levelData: gameScene.levelEncoding), for: gameScene)
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("LEVEL ENCODING FOR GAME SCENE: \(levelEncoding)")
        let scene = GameScene(size: CGSize(width: 2048.0, height: 1536.0))
        scene.levelEncoding = levelEncoding
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
