//
//  SplashScreenViewController.swift
//  DamIt
//
//  Created by Nikhil Bodicharla on 10/20/20.
//

import UIKit

class SplashScreenViewController: UIViewController {

    
    @IBOutlet weak var waveImage: UIImageView!
    override func viewDidLoad() {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = waveImage.bounds
        let startColor = UIColor(red: 30/255, green: 113/255, blue: 79/255, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        waveImage.layer.insertSublayer(gradient, at: 0)
        view.addSubview(waveImage)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations:{
            self.waveImage.frame.origin.y -= 400
            self.waveImage.frame.origin.x += 100
            self.view.backgroundColor = UIColor.clear
            self.waveImage.backgroundColor = UIColor.clear
        }, completion: { done in
            if done{
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier:
                     "mainScreen") {
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        let navigationController = UINavigationController(rootViewController: vc)

                        self.present(navigationController, animated: true, completion: nil)
                    }
                })
            }
            
        })
        // Do any additional setup after loading the view.
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // make nav bar  come back for next pages
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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