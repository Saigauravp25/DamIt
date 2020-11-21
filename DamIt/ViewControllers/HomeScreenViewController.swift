//
//  ViewController.swift
//  DamIt
//
//  Created by kishanS on 9/30/20.
//

import UIKit
import GameKit
import CoreData
import Firebase
import AVKit

var backgroundMusicPlayer: AVAudioPlayer!

class HomeScreenViewController: UIViewController, SettingsViewControllerDelegate {
    
    let settingsSegueID = "settingsSegue"
    let levelPackSegueID = "LevelPackSelectSegue"
    var user = ""
    var userData: [NSManagedObject]!
    var ref: DatabaseReference!
    var userLevelData = ""
    var audioPlayer: AVAudioPlayer!
    
    
    var notificationManager = NotificationManager()
    
   
    override func viewDidLoad() {
//        navigationController?.setNavigationBarHidden(true, animated: true)
        ref = Database.database().reference()
        var userID = Auth.auth().currentUser?.email
        // reformatting the email again to query the database
        userID = userID!.replacingOccurrences(of: "@", with: ",")
        userID = userID!.replacingOccurrences(of: ".", with: ",")
        let exm = Database.database().reference().child("users")
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            self.userLevelData = value?["levelPack"] as? String ?? ""

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        super.viewDidLoad()
        retrieveUser()
        playBackgroundMusic(backgroundMusic: "retroBackgroundMusic")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        // make nav bar  come back for next pages
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func playBackgroundMusic(backgroundMusic: String) {
        print("Music on:", gameSettings.settings[1])
        let url = Bundle.main.url(forResource: backgroundMusic, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.numberOfLoops = -1
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "backroundMusicSwitch") {
            audioPlayer.play()
        }
        backgroundMusicPlayer = audioPlayer
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
            vc.audioPlayer = self.audioPlayer
            gameSettings.settings = vc.settingsArray
            vc.notificationManager = notificationManager
        }
        if(segue.identifier == "LevelPackSelectSegue" ){
            let vc = segue.destination as! LevelPackViewController
            vc.delegate = self
            vc.userData = userData
            vc.userLevelData = userLevelData
        }
        if (segue.identifier == "tutorialSegue") {
            let vc = segue.destination as! GameViewController
            vc.levelEncoding = "00001205RRRLLRRRLARRRAARRRAARRRAARRRAARRRAARRRAARRRBARRRAAAAAAARRRAA"
            vc.isTutorial = true
        }
    }
    
    
    func settingsArray() -> [Bool] {
        var arr = [true, false, true ,false]
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
    func retrieveUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "id = %@", user)
        
        
        do {
            try userData = context.fetch(request) as? [NSManagedObject]
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
}

