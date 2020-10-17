//
//  SettingTableViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/1/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

let saveTime: UserDefaults = UserDefaults.standard

class SettingStaticCellTableViewController: UITableViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var breakfastTimePicker: UIDatePicker!
    
    @IBOutlet weak var dinnerTimePicker: UIDatePicker!
    
    let formatter = DateFormatter()
    
    
    var chosenBreakfastTime = Date()
    var chosenDinnerTime = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isKeyPresentInUserDefaults(key: breakfastKey)) {
            let breakfastTime = saveTime.object(forKey: breakfastKey)
            breakfastTimePicker.date = breakfastTime as! Date
        }
        
        if (isKeyPresentInUserDefaults(key: dinnerKey)) {
            let dinnerTime = saveTime.object(forKey: dinnerKey)
            dinnerTimePicker.date = dinnerTime as! Date
        }
        
    }
    
    
    
    @IBAction func didChangeSwitch(_ sender: Any) {
    }
    
    
    let breakfastKey:String = "breakfastTime"

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    @IBAction func breakfastTimeChosen(_ sender: Any) {
        
        chosenBreakfastTime = breakfastTimePicker.date
        
        if notificationSwitch.isOn {
            
            //set notification for breakfast time
            let content = UNMutableNotificationContent()
            content.title = "ペットの朝ごはんの時間です"
            content.subtitle = "お腹すいたよ〜"
            
            
            let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: chosenBreakfastTime)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)
            
            let notificationReq = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
            
        }
        
        //save chosen time in FIREBASE
        saveTime.setValue(chosenBreakfastTime, forKey: breakfastKey)
        
    }

    let dinnerKey:String = "dinnerTime"
    
    @IBAction func dinnerTimeChosen(_ sender: Any) {
        
        chosenDinnerTime = dinnerTimePicker.date
        
        if notificationSwitch.isOn {
            
            //set notification for dinner time
            let content = UNMutableNotificationContent()
            content.title = "ペットの晩ごはんの時間です"
            content.subtitle = "お腹すいたよ〜"
            
            
            let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: chosenDinnerTime)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)
            
            let notificationReq = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
            
        }
        
        //save chosen time in Userdefaults
        saveTime.setValue(chosenDinnerTime, forKey: dinnerKey)
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.string(from: chosenDinnerTime)
        print(formatter.string(from: chosenDinnerTime))
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let accountViewController = storyboard.instantiateViewController(identifier: "AccountNavController")
        view.window?.rootViewController = accountViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
    
    
    
}
