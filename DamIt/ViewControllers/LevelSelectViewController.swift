//
//  LevelSelectViewController.swift
//  DamIt
//
//  Created by kishanS on 10/8/20.
//

import UIKit
import CoreData

class LevelSelectViewController: UIViewController {

    
    var levelsCompleted : [Bool]!
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Level Select"
        
        //button set up
//        buttonSetup()
        // Do any additional setup after loading the view.
    }
    
//    func buttonSetup(){
//        var index = 0
//        for boolean in levelsCompleted {
//            buttons[index].isEnabled = boolean
//            index += 1
//        }
//    }
    
    @IBAction func levelButtonPressed(_ sender: Any) {
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
