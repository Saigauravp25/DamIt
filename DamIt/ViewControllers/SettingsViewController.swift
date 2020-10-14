//
//  SettingsViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func changedSoundFX(isOn:Bool)
    func changedBackgroundMusic(isOn:Bool)
    func changedDailyNotification(isOn:Bool)
    func changedDpad(isOn:Bool)
}

class SettingsViewController: UIViewController {
    
    
    @IBOutlet var soundSwitch: UISwitch!
    @IBOutlet var backgroundMusicSwitch: UISwitch!
    @IBOutlet var notificationsSwitch: UISwitch!
    @IBOutlet var touchControlSwitch: UISwitch!
    
    let customizeSegueID = "customizeCharacterSegue"
    var delegate: SettingsViewControllerDelegate!
    var settingsArray: [Bool]!
    
    var style: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Settings"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        soundSwitch.isOn = settingsArray[0]
        backgroundMusicSwitch.isOn = settingsArray[1]
        notificationsSwitch.isOn = settingsArray[2]
        touchControlSwitch.isOn = settingsArray[3]
        
    }
    
    @IBAction func settingsToggleChanged(_ sender: Any) {
        let toggle = sender as! UISwitch
        switch toggle.tag {
            case 0:
                //sound fx
                delegate.changedSoundFX(isOn: toggle.isOn)
                print(toggle.isOn)
            case 1:
                //background music
                delegate.changedBackgroundMusic(isOn: toggle.isOn)
                print(toggle.isOn)
            case 2:
                //notificaitons
                delegate.changedDailyNotification(isOn: toggle.isOn)
                print(toggle.isOn)
            case 3 :
                //dpad
                delegate.changedDpad(isOn: toggle.isOn)
                print(toggle.isOn)
        default:
            print("toggle not handled")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == customizeSegueID) {
            let vc = segue.destination as! CustomizeCharacterViewController
        }
    }
    
}
