//
//  LevelPackViewController.swift
//  DamIt
//
//  Created by Nikhil Bodicharla on 10/18/20.
//

import UIKit
import CoreData

class LevelPackViewController: UIViewController {

    @IBOutlet weak var checkcollectionview: UICollectionView!
    var delegate: UIViewController!
    var levelData = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        levelData = Array(repeating:false, count: 3)
        retrieveLevels()
        if(levelData.count == 0){
            storeLevels()
            retrieveLevels()
        }
    }
    

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "levelSegue"){
            let vc = segue.destination as! LevelSelectViewController
            vc.levelsCompleted = levelData
        }
    }
}
extension LevelPackViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = checkcollectionview.dequeueReusableCell(withReuseIdentifier: "check", for: indexPath) as? checkCollectionViewCell
      

        cell?.buttontitle.setTitle("Level Pack \(String(indexPath.row + 1))", for: .normal)
        return cell!
    }
    
    
}
extension LevelPackViewController {
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
        
        for level in fetchedResults! {
            if let completed = level.value(forKey: "completed") as? Bool{
                if let id = level.value(forKey: "id") as? Int{
                    levelData[id] = completed
                }
            }
        }
        
    }
}
