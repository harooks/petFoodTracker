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
//import FirebaseMessaging

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    let formatter = DateFormatter()
    
    let dinnerTime = saveTime.object(forKey: "dinnerTime")
    
    
    let currentTime = Date()
    
    let breakfastTime = saveTime.object(forKey: "breakfastTime")
    
    var timer = Timer()
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ask for notification permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            
        }
        
    }
    
    @IBAction func touchDownMainButton(_ sender: Any) {
        
        
 
        
        let alert: UIAlertController = UIAlertController(title: "ご飯をあげた", message: "ご飯をあげましたか？", preferredStyle: .alert)
        
            
            alert.addAction (
                UIAlertAction (title: "キャンセル", style: .cancel))

            alert.addAction (
                UIAlertAction (
                    title: "OK", style: .default, handler: { action in
                        
                        self.petFed()
                        
                        //3 時間後にオフにする
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                            self.count += 1
                            print(self.count)
                            
                            if self.count == 10800 {
                                timer.invalidate()
                                self.petNotFed()
                                self.count = 0
                            }
                           
                        })
            }
            ))
        present(alert, animated: true, completion: nil)

    }
    
    
    
    func petFed() {

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


            
            //push notification "pet is fed"

        
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
