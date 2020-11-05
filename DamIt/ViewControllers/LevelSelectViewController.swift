//
//  LevelSelectViewController.swift
//  DamIt
//
//  Created by kishanS on 10/8/20.
//

import UIKit
import CoreData

protocol LevelUpdate{
    func updateLevel(levelNumber: Int)
}

class LevelSelectViewController: UIViewController, LevelUpdate {
   

    
    var levelsCompleted : [Bool]!
    var levelData: [String]!
    var currentLevel: Int!
    var userLevels = 0 
    
    var selectedLevelEncoding = ""
    var levelPack: Int!
    let segue: String = "gameSegue"
    
    @IBOutlet var buttons: [UIButton]!
   
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Level Select"
        // hardcoded for now 
//        if levelPack != 1 {
            for button in buttons {
                let buttonNumber = Int((button.titleLabel?.text)!)!
                if buttonNumber > self.userLevels{
                   button.isEnabled = false
                    
                }
            }
//        }
    }
    
//    func buttonSetup(){
//        var index = 0
//        for boolean in levelsCompleted {
//            buttons[index].isEnabled = boolean
//            index += 1
//        }
//    }
    
    @IBAction func levelButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        self.currentLevel = button.tag
        selectedLevelEncoding = levelData[self.currentLevel]
        performSegue(withIdentifier: segue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == self.segue) {
            let vc = segue.destination as! GameViewController
            vc.levelEncoding = self.selectedLevelEncoding
            vc.levelData = self.levelData
            vc.currentLevel = self.currentLevel
            vc.delegate = self
        }
    }
    func updateLevel(levelNumber: Int) {
        buttons[levelNumber].isEnabled = true
    }
    
}
