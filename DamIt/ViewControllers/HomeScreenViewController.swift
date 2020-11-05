//
//  ViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit
import GameKit
import CoreData

class HomeScreenViewController: UIViewController, SettingsViewControllerDelegate {
    
    let settingsSegueID = "settingsSegue"
    let levelPackSegueID = "LevelPackSelectSegue"
    
   
    override func viewDidLoad() {
//        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        // make nav bar  come back for next pages
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
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
//        self.navigationController?.isNavigationBarHidden = false
        if (segue.identifier == settingsSegueID){
            let vc = segue.destination as! SettingsViewController
            vc.delegate = self
            vc.settingsArray = settingsArray()
        }
        if(segue.identifier == "LevelPackSelectSegue" ){
            let vc = segue.destination as! LevelPackViewController
            vc.delegate = self
        }
        if (segue.identifier == "tutorialSegue") {
            let vc = segue.destination as! GameViewController
            vc.levelEncoding = "00001205RRRLLRRRLARRRAARRRAARRRAARRRAARRRAARRRAARRRBARRRAAAAAAARRRAA"
            vc.isTutorial = true
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
            arr[1] = defaults.bool(forKey: "backroundMusicSwitch")
        }
        if(notificaitonsSet == 1){
            arr[2] = defaults.bool(forKey: "notificationSwitch")
        }
        if(dpad == 1){
            arr[3] = defaults.bool(forKey: "dpadSwitch")
        }
        return arr
    }
    
    @IBAction func playerModeButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 1 || tag == 2 {
            disclosureAlert()
        }
        performSegue(withIdentifier: levelPackSegueID , sender: self)
    }
    
    @IBAction func tutorialButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "tutorialSegue", sender: self)
    }
    
    func disclosureAlert() {
        let controller = UIAlertController(title: "Disclosure", message: "This mode is not yet implemented. Planned as a strech goal or future release.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
}

