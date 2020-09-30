//
//  ViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit

class HomeScreenViewController: UIViewController, SettingsViewControllerDelegate {

    
    
    let settingsSegueID = "settingsSegue"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    func changedSoundFX(isOn: Bool) {
        // change user defaults
    }
    
    func changedBackgroundMusic(isOn: Bool) {
        //
    }
    
    func changedDailyNotification(isOn: Bool) {
        //
    }
    
    func changedDpad(isOn: Bool) {
        //
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == settingsSegueID){
            let vc = segue.destination as! SettingsViewController
            vc.delegate = self
        }
    }
}

