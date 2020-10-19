//
//  LevelPackViewController.swift
//  DamIt
//
//  Created by Nikhil Bodicharla on 10/18/20.
//

import UIKit

class LevelPackViewController: UIViewController {

    @IBOutlet weak var checkcollectionview: UICollectionView!
    var delegate: UIViewController!

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
