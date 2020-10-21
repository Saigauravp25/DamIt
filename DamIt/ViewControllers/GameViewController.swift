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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("LEVEL ENCODING FOR GAME SCENE: \(levelEncoding)")
        let scene = GameScene(size: CGSize(width: 2048.0, height: 1536.0))
        scene.scaleMode = .aspectFill
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
