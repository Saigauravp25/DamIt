//
//  SettingsViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func changedSoundFX()
    func changedBackgroundMusic()
    func changedDailyNotification()
    func changedDpad()
}

class SettingsViewController: UIViewController, CustomizeCharacterViewControllerDelegate {
    
    
    
    let customizeSegueID = "customizeCharacterSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
