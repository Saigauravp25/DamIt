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
    
    var levelData = [Bool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "Home Screen"
//        navigationItem.backButtonTitle = "Home Screen"
        authenticateUser()
        //retrieve data
        
        //if no levels stored then store data
        //clearCoreData()
        retrieveLevels()
        if(levelData.count == 0){
            levelData = Array(repeating:false, count: 3)
            storeLevels()
            retrieveLevels()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func authenticateUser(){
        let player = GKLocalPlayer.local
        player.authenticateHandler = { vc, error in
            guard error == nil else {
                let alert = UIAlertController (title: "OOPS, an error Occured", message: "please try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                print(error?.localizedDescription ?? "")
                return
            }
            if let vc = vc {
                self.present(vc, animated: true, completion: nil)
            }
        }
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
        self.navigationController?.isNavigationBarHidden = false
        if (segue.identifier == settingsSegueID){
            let vc = segue.destination as! SettingsViewController
            vc.delegate = self
            vc.settingsArray = settingsArray()
        }
        if(segue.identifier == "LevelPackSelectSegue" ){
            let vc = segue.destination as! LevelPackViewController
            vc.delegate = self
//            vc.levelsCompleted = levelData
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
    
    @IBAction func playerModeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: levelPackSegueID , sender: self)
    }
    
    //MARK: - Storing level 1 stuff
    
    func storeLevels() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let level = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level.setValue(true, forKey: "completed")
        level.setValue(0, forKey: "id")
        
        let level1 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level1.setValue(false, forKey: "completed")
        level1.setValue(1, forKey: "id")
        
        let level2 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level2.setValue(false, forKey: "completed")
        level2.setValue(2, forKey: "id")
        
        // Commit the changes
        do {
            print("saving data")
            try context.save()
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func clearCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LevelData")
        
        var fetchedResults: [NSManagedObject]
        
        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            
            if fetchedResults.count > 0 {
                
                for result:AnyObject in fetchedResults {
                    context.delete(result as! NSManagedObject)
                    //print("\(result.value(forKey:"name")!) has been deleted")
                }
            }
            try context.save()
            
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        
    }
    
    func retrieveLevels() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LevelData")
        
        var fetchedResults: [NSManagedObject]? = nil
        
//        insert predicates here
        //let predicate = NSPredicate(format: "name CONTAINS[c] 'ie'")
        //request.predicate = predicate
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
//        for level in fetchedResults! {
//            if let completed = level.value(forKey: "completed") as? Bool{
//                if let id = level.value(forKey: "id") as? Int{
//                    levelData[id] = completed
//                }
//            }
//        }
        
    }
}

