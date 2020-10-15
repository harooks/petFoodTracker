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
    
    @IBOutlet weak var breakfastButton: UIButton!
    
    @IBOutlet weak var dinnerButton: UIButton!
    
    
    let formatter = DateFormatter()
    
    let dinnerTime = saveTime.object(forKey: "dinnerTime")
    
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
        
        let currentUser = Auth.auth().currentUser
        let uidString = String(currentUser!.uid)
        let didFeedPetRef = db.collection("users").document(uidString)
        
        didFeedPetRef.getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else { return }
            let breakfastStatus = data["didGiveBreakfast"] as? Bool
            let dinnerStatus = data["didGiveDinner"] as? Bool

            if breakfastStatus! {
                self.fedBreakfast()
            } else {
               //change breakfast UI
                self.notFedBreakfast()
            }
            
            if dinnerStatus! {
                self.fedDinner()
            } else {
                self.notFedDinner()
            }
        }
    }
    
    
    @IBAction func touchDownBreakfastButton(_ sender: Any) {
        
        
        let alert: UIAlertController = UIAlertController(title: "朝飯をあげた", message: "ご飯をあげましたか？", preferredStyle: .alert)

        alert.addAction (
            UIAlertAction (title: "キャンセル", style: .cancel))
        
        alert.addAction (
            UIAlertAction (
                title: "OK", style: .default, handler: { action in
                    
                    self.fedBreakfast()
                    
                }
            ))
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func touchDownDinnertButton(_ sender: Any) {
        
        
        let alert: UIAlertController = UIAlertController(title: "夜飯をあげた", message: "ご飯をあげましたか？", preferredStyle: .alert)

        alert.addAction (
            UIAlertAction (title: "キャンセル", style: .cancel))
        
        alert.addAction (
            UIAlertAction (
                title: "OK", style: .default, handler: { action in
                    
                    self.fedDinner()
                    
                }
            ))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func fedBreakfast() {
        
        //Change UI
        self.breakfastButton.setImage(UIImage(named: "foodFull"), for: .normal)
        
        //change didFeedPet to true
        let currentUser = Auth.auth().currentUser
        let uidString = String(currentUser!.uid)
        let didFeedPetRef = db.collection("users").document(uidString)
        
        
        didFeedPetRef.updateData(["didGiveBreakfast" : true
        ]) { err in
            if err != nil {
                print("Error updating document")
            } else {
                print("document successfully updated")
            }
        }
    }
    
    func fedDinner() {
        //Change UI
        self.dinnerButton.setImage(UIImage(named: "foodFull"), for: .normal)
        
        //change didFeedPet to true
        let currentUser = Auth.auth().currentUser
        let uidString = String(currentUser!.uid)
        let didFeedPetRef = db.collection("users").document(uidString)
        
        
        didFeedPetRef.updateData(["didGiveDinner" : true
        ]) { err in
            if err != nil {
                print("Error updating document")
            } else {
                print("document successfully updated")
            }
        }
        
    }
    
    func notFedBreakfast() {

        
        //Change UI
        self.breakfastButton.setImage(UIImage(named: "foodEmpty"), for: .normal)
   
        
        //change didFeedPet to true
        let currentUser = Auth.auth().currentUser
        let uidString = String(currentUser!.uid)
        let didFeedPetRef = db.collection("users").document(uidString)
        
        
        didFeedPetRef.updateData(["didGiveBreakfast" : false
        ]) { err in
            if err != nil {
                print("Error updating document")
            } else {
                print("document successfully updated")
            }
        }
    }
    
    func notFedDinner(){
        //Change UI
        self.dinnerButton.setImage(UIImage(named: "foodEmpty"), for: .normal)
   
        
        //change didFeedPet to true
        let currentUser = Auth.auth().currentUser
        let uidString = String(currentUser!.uid)
        let didFeedPetRef = db.collection("users").document(uidString)
        
        
        didFeedPetRef.updateData(["didGiveDinner" : false
        ]) { err in
            if err != nil {
                print("Error updating document")
            } else {
                print("document successfully updated")
            }
        }
        
    }
    
    
    
    
}
