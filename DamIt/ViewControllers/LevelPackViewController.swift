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
    var levelData = [String]()
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        clearCoreData()
        retrieveLevels()
        if(levelData.count == 0){
            storeLevels()
            retrieveLevels()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "levelSegue"){
            let vc = segue.destination as! LevelSelectViewController
            let button = sender as? UIButton
            vc.levelPack = button?.tag
            vc.levelData = levelData
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
        cell?.buttontitle.tag = indexPath.row + 1
        return cell!
    }
    
    
}
extension LevelPackViewController {
    func storeLevels() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let level1 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level1.setValue(true, forKey: "completed")
        level1.setValue(0101, forKey: "id")
        let level1Encoding = "01011004RLLLLLAAAAAALLAALAAARRBAAAAALLAALLLARRLL"
        level1.setValue(level1Encoding, forKey: "encoding")
        
        let level2 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        let level2Encoding = "01021604LLLLRAAARRLAAAAARRAAAAAALAAALLLARRAARBAARRLLAAAAAAAARRLARLLLRLLL"
        level2.setValue(false, forKey: "completed")
        level2.setValue(0102, forKey: "id")
        level2.setValue(level2Encoding, forKey: "encoding")
        
        let level3 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level3.setValue(false, forKey: "completed")
        level3.setValue(0103, forKey: "id")
        let level3Encoding = "01031003RLLRLALAARAARRLRRBRLLAAARRALLL"
        level3.setValue(level3Encoding, forKey: "encoding")
        
        let level4 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level4.setValue(false, forKey: "completed")
        level4.setValue(0104, forKey: "id")
        let level4Encoding = "01041004RLLLRLLARLAARAAARLAARRBAAAAARAAARLAARRLA"
        level4.setValue(level4Encoding, forKey: "encoding")
        
        let level5 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)

        level5.setValue(false, forKey: "completed")
        level5.setValue(0105, forKey: "id")
        let level5Encoding = "01051407RLLLLLALLLLLAARRLLAAALLLAAAARLAAAAARBAAAAARRAAAAARAAAAAARRRAAAALLLLAAALLAAAAALAAAAAALLAAAAALLLLLL"
        level5.setValue(level5Encoding, forKey: "encoding")
        
        let level6 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)

        level6.setValue(false, forKey: "completed")
        level6.setValue(0106, forKey: "id")
        let level6Encoding = "01061106LLLLAALLAAAALBAAAARRAAAALLLAAAAAAAAALLLAAALLLLAALLLLLALLLLLLRRLAAA"
        level6.setValue(level6Encoding, forKey: "encoding")
        
        let level9 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level9.setValue(false, forKey: "completed")
        level9.setValue(0109, forKey: "id")
        let level9Encoding = "01091405LLLLLAAAAARRLLLLLLLALAAAALLAAALLLLARLLAALLBAALAAAARRAAALLLAARRLLLRRLLL"
        level9.setValue(level9Encoding, forKey: "encoding")
        
        let level10 = NSEntityDescription.insertNewObject(
            forEntityName: "LevelData", into:context)
        
        level10.setValue(false, forKey: "completed")
        level10.setValue(0110, forKey: "id")
        let level10Encoding = "01101805RRLAALLAAAAAAAARRLAAAAAAAAAAAALAAAARLLAALLBAAAAAAARRLLARAAAARRLLLAAAAARLLAARLAAARLAAARLLLL"
        //01101805RRLAALLAAAAAAAARRLAAAAAAAAAAAALAAAARLLAALLBAAAAAAARRLLARAAAARRLLLLAAAARLAAARLLAARLLLARLLLL
        level10.setValue(level10Encoding, forKey: "encoding")
        
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
        
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            if fetchedResults!.count > 0{
                //results exist
                levelData = Array(repeating: "", count: 10)
                for level in fetchedResults!{
                    if let completed = level.value(forKey: "completed") as? Bool{
                        if let id = level.value(forKey: "id") as? Int{
                            if let encoding = level.value(forKey: "encoding") as? String {
                                let levelNum = Int(encoding.substring(with: 2..<4))
                                let index = levelNum! - 1
                                levelData[index] = encoding
                            }
                        }
                    }
                }
            }
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}
