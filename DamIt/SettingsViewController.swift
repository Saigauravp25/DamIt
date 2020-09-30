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

class SettingsViewController: UIViewController, CustomizeCharacterViewControllerDelegate {
    
    
    
    let customizeSegueID = "customizeCharacterSegue"
    
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func characterOption(styleNumber: Int) {
        print("Style Number Selected \(styleNumber)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == customizeSegueID) {
            let vc = segue.destination as! CustomizeCharacterViewController
            vc.delegate = self
        }
    }
    
}
