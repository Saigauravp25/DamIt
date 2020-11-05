//
//  LevelSelectViewController.swift
//  DamIt
//
//  Created by kishanS on 10/8/20.
//

import UIKit
import CoreData

protocol LevelUpdate{
    func updateLevel(levelpack: Int, levelNumber: Int)
}

class LevelSelectViewController: UIViewController, LevelUpdate {
   

    
    var levelsCompleted : [Bool]!
    var levelData: [String]!
    var currentLevel: Int!
    var userLevels:Int!
    var userPacks:Int!
    
    var selectedLevelEncoding = ""
    var levelPack: Int!
    let segue: String = "gameSegue"
    
    @IBOutlet var buttons: [UIButton]!
   
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttons {
            let buttonNumber = Int((button.titleLabel?.text)!)!
            if(levelPack >= userPacks){
                if buttonNumber > self.userLevels{
                   button.isEnabled = false
                }
            }
        }
    }
    
    @IBAction func levelButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        self.currentLevel = button.tag
        let index = (levelPack - 1) * 10 + self.currentLevel
        selectedLevelEncoding = levelData[index]
        performSegue(withIdentifier: segue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == self.segue) {
            let vc = segue.destination as! GameViewController
            vc.levelEncoding = self.selectedLevelEncoding
            vc.levelData = self.levelData
            vc.currentLevel = self.currentLevel
            vc.currentPack = levelPack
            vc.delegate = self
        }
    }
    
    func updateLevel(levelpack:Int, levelNumber: Int) {
        var index = (levelpack - 1) * 10
        index += levelNumber
        buttons[index - 1].isEnabled = true
    }
    
}
