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
        let defaults = UserDefaults.standard
        defaults.set(1,forKey: "sfxSet")
        defaults.set(isOn,forKey: "soundFXSwitch")
    }
    
    func changedBackgroundMusic(isOn: Bool) {
        //
        let defaults = UserDefaults.standard
        defaults.set(1,forKey: "bgmusicSet")
        defaults.set(isOn,forKey: "backroundMusicSwitch")
    }
    
    func changedDailyNotification(isOn: Bool) {
        //
        let defaults = UserDefaults.standard
        defaults.set(1,forKey: "notificationsSet")
        defaults.set(isOn,forKey: "notificationSwitch")
    }
    
    func changedDpad(isOn: Bool) {
        //
        let defaults = UserDefaults.standard
        defaults.set(1,forKey: "dpadSet")
        defaults.set(isOn,forKey: "dpadSwitch")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == settingsSegueID){
            let vc = segue.destination as! SettingsViewController
            vc.delegate = self
            vc.settingsArray = settingsArray()
            print("prepare for segue")
            
        }
    }
    
    
    func settingsArray() -> [Bool] {
        var arr = [true, true, true ,false]
        let defaults = UserDefaults.standard
        let sfxSet = defaults.integer(forKey: "sfxSet")
        let bgmSet = defaults.integer(forKey: "bgmusicSet")
        let notificaitonsSet = defaults.integer(forKey: "notificationsSet")
        let dpad = defaults.integer(forKey: "dpadSet")
        if(sfxSet == 1) {
            arr[0] = defaults.bool(forKey: "soundFXSwitch")
        }
        if(bgmSet == 1){
            arr[1] = defaults.bool(forKey: "backgroundMusicSwitch")
        }
        if(notificaitonsSet == 1){
            arr[2] = defaults.bool(forKey: "notificationSwitch")
        }
        if(dpad == 1){
            arr[3] = defaults.bool(forKey: "dpadSwitch")
        }
        return arr
    }
}

