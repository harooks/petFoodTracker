//
//  HomeViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 9/29/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    let formatter = DateFormatter()
    
    let dinnerTime = saveTime.object(forKey: "dinnerTime") as! Date
    
    
    let currentTime = Date()
    
    let breakfastTime = saveTime.object(forKey: "breakfastTime") as! Date
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ask for notification permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            
        }
        
    }
    
    @IBAction func touchDownMainButton(_ sender: Any) {
        
        
        //while time is between breakfasttime (or dinnertime) and replace time
        petFed()
        
    }
    
    
    
    func petFed() {
        
        let alert: UIAlertController = UIAlertController(title: "ご飯をあげた", message: "ご飯をあげましたか？", preferredStyle: .alert)
        
        
//        while (currentTime >= breakfastTime && currentTime <= (Calendar.current.date(byAdding: .hour, value: -2, to: dinnerTime)!)) || (currentTime >= dinnerTime && currentTime <= (Calendar.current.date(byAdding: .hour, value: -22, to: dinnerTime)!)) {
            
            
            alert.addAction (
                UIAlertAction (title: "キャンセル", style: .cancel))

            alert.addAction (
                UIAlertAction (
                    title: "OK", style: .default, handler: { action in
                        //Change UI
                        self.mainButton.setImage(UIImage(named: "foodFull"), for: .normal)
                        self.mainLabel.text = "ご飯ありがとう！"
                        
                        //change didFeedPet to true
                        let currentUser = Auth.auth().currentUser
                        let uidString = String(currentUser!.uid)
                        let didFeedPetRef = db.collection("users").document(uidString)
                        
                        
                        didFeedPetRef.updateData(["didFeedPet" : true
                        ]) { err in
                            if err != nil {
                                print("Error updating document")
                            } else {
                                print("document successfully updated")
                            }
                        }
                    }
                ))

            
            //push notification "pet is fed"
        
            
            
            present(alert, animated: true, completion: nil)
        //}
        
        
        
    }
    
    func petNotFed() {
        
        
        
        
        //Change UI
        mainButton.setImage(UIImage(named: "foodEmpty"), for: .normal)
        mainLabel.text = "お腹すいたよ〜"
        
        //change didFeedPet to true
        let currentUser = Auth.auth().currentUser
        let uidString = String(currentUser!.uid)
        let didFeedPetRef = db.collection("users").document(uidString)
        
        
        didFeedPetRef.updateData(["didFeedPet" : false
        ]) { err in
            if err != nil {
                print("Error updating document")
            } else {
                print("document successfully updated")
            }
        }
        
        
        //push notification "pet is fed"
        
        
        //
        
    }
    
    
}
