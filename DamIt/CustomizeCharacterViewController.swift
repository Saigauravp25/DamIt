//
//  CustomizeCharacterViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit

protocol CustomizeCharacterViewControllerDelegate{
    func characterOption(styleNumber:Int)
}
class CustomizeCharacterViewController: UIViewController {

    var delegate: CustomizeCharacterViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func skinStyleSelected(_ sender: Any) {
        let button = sender as! UIButton
        let style = button.tag
        delegate.characterOption(styleNumber: style)
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
