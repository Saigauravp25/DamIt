//
//  LoginViewController.swift
//  DamIt
//
//  Created by Nikhil Bodicharla on 10/27/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var signUpText: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var loginStatus: UILabel!
    @IBAction func onSegChange(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        // hiding certain fields for sign in page
        case 0:
            confirmPassword.isHidden = true
            confirmPasswordLabel.isHidden = true
            signUpText.setTitle("Sign In", for: UIControl.State(rawValue: 0))
        case 1:
            confirmPassword.isHidden = false
            confirmPasswordLabel.isHidden = false
            signUpText.setTitle("Sign Up", for: UIControl.State(rawValue: 0))
        default: break
           }
    }
    @IBAction func signUp(_ sender: Any) {
        if segCtrl.selectedSegmentIndex == 0 {
        guard let email = userName.text,
              let password = self.password.text,
              email.count > 0,
              password.count > 0
        else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password){
            user, error in
            if let error = error, user == nil {
                // display error status
                self.loginStatus.text = error.localizedDescription
                self.loginStatus.numberOfLines = 0
            }
            else{
                // if good login, go to next page
                self.performSegue(withIdentifier: "toGame", sender: self)
            }
        }
    }
        else if segCtrl.selectedSegmentIndex == 1 {
            let email = userName.text
            let newPassword = password.text
            // create user for sign up
            Auth.auth().createUser(withEmail: email!, password: newPassword!){
                user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: email!, password: newPassword!)
                    // once user has created account, log them in
                    self.performSegue(withIdentifier: "toGame", sender: self)
                }
                else{
                    self.loginStatus.text = error?.localizedDescription
                    self.loginStatus.numberOfLines = 0
                }
            }
        }
    }
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

}
