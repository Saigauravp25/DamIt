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
    
    
    var notificationManager: NotificationManager!
    let customizeSegueID = "customizeCharacterSegue"
    var delegate: SettingsViewControllerDelegate!
    var settingsArray: [Bool]!
    
    var style: Int?
    
    @IBOutlet var soundSwitch: UISwitch!
    @IBOutlet var backgroundMusicSwitch: UISwitch!
    @IBOutlet var notificationsSwitch: UISwitch!
    @IBOutlet var touchControlSwitch: UISwitch!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        soundSwitch.isOn = settingsArray[0]
        backgroundMusicSwitch.isOn = settingsArray[1]
        notificationsSwitch.isOn = settingsArray[2]
        touchControlSwitch.isOn = settingsArray[3]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        disclosureAlert()
    }
    
    func disclosureAlert() {
        let controller = UIAlertController(title: "Disclosure", message: "These features are not yet implemented. Planned for Beta Release.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
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
                if(toggle.isOn){
                    notificationManager.scheduleNotifications()
                } else {
                    notificationManager.unscheduleNotifications()
                }
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
