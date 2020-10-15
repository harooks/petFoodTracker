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
        saveTime.setValue(chosenBreakfastTime, forKey: "breakfastTime")
        saveTime.setValue(chosenDinnerTime, forKey: "dinnerTime")

        chosenBreakfastTime = breakfastTimePicker.date
        chosenDinnerTime = dinnerTimePicker.date

        //設定してある時間を取得してPicker に表示する
        let breakfastTime = saveTime.object(forKey: "breakfastTime")
        breakfastTimePicker.date = breakfastTime as! Date

        let dinnerTime = saveTime.object(forKey: "dinnerTime")
        dinnerTimePicker.date = dinnerTime as! Date
        

    }
    
    
    
    @IBAction func didChangeSwitch(_ sender: Any) {
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
        saveTime.setValue(chosenBreakfastTime, forKey: "breakfastTime")
  
    }
    
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
        saveTime.setValue(chosenDinnerTime, forKey: "dinnerTime")
        
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
