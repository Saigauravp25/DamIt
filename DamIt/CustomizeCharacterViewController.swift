//
//  CustomizeCharacterViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit

class CustomizeCharacterViewController: UIViewController {
    
    var style : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Customize Character"
        style = UserDefaults.standard.integer(forKey: "customStyle")
        print("Style Number \(style!)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func skinStyleSelected(_ sender: Any) {
        let button = sender as! UIButton
        let style = button.tag
        let defaults = UserDefaults.standard
        defaults.setValue(style, forKey: "customStyle")
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
