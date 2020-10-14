//
//  DogViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/11/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import RealmSwift

class DogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dogTable: UITableView!
    
    var dogArray: [Dog] = []
    
    let saveDog = UserDefaults.standard

    let realm = try! Realm()
    
    let editSegueIdentifier = "addDog" 

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dogTable.dataSource = self
        dogTable.delegate = self
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dogArray = realm.objects(Dog.self).map { $0 }
        dogTable.reloadData()
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == editSegueIdentifier {
//            let viewController = segue.destination as! AddDogViewController
//           // viewController.dog = (sender as? Dog)!
//        }
//    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        performSegue(withIdentifier: editSegueIdentifier, sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogTableViewCell
        
        cell.dogName.text = dogArray[indexPath.row].name
        print("name saved")
        cell.dogPicture.image = dogArray[indexPath.row].dogImage
        print("pic saved")
       // print(dogArray[indexPath.row].dogImage)
        
//       if dogArray[indexPath.row].dogImage != nil {
            
//        if dogArray[indexPath.row].dogImage is UIImage {
//            print ("uiimage")
//        } else if dogArray[indexPath.row].dogImage is Data {
//            print ("Data")
//        } else {
//            print ("otherssss")
//        }
//        } else {
//            print ("nillll")
//        }
//

 //   }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dogTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: editSegueIdentifier, sender: dogArray[indexPath.row])
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        try! realm.write {
//            if editingStyle == .delete {
//                try! realm.write {
//                               realm.delete(dogArray[indexPath.row])
//                           }
//
//                dogArray.remove(at: indexPath.row)
//                          tableView.deleteRows(at: [indexPath], with: .automatic)
//                        }
//            }
//        }
    
    
    // セルの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCell.EditingStyle.delete) {
            // Realm内のデータを削除
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(self.dogArray[indexPath.row])
                }
                dogTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            } catch {
            }
        }
    }

    
  
    
    
    
}
