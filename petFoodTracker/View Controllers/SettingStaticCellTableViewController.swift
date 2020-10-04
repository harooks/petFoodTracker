//
//  SettingTableViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/1/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit

let saveTime: UserDefaults = UserDefaults.standard

class SettingStaticCellTableViewController: UITableViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var breakfastTimePicker: UIDatePicker!
    
    @IBOutlet weak var dinnerTimePicker: UIDatePicker!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    @IBAction func didChangeSwitch(_ sender: Any) {
      
        
    }
    
    @IBAction func breakfastTimeChosen(_ sender: Any) {
        
        let chosenBreakfastTime = breakfastTimePicker.date
        
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
        
        //make
        
        //save chosen time in Userdefaults
        saveTime.setValue(chosenBreakfastTime, forKey: "breakfastTime")
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.string(from: chosenBreakfastTime)
        print(formatter.string(from: chosenBreakfastTime))
        //print(formatter.string(from: triggerTime))
        
    }
    
    @IBAction func dinnerTimeChosen(_ sender: Any) {
        
        let chosenDinnerTime = dinnerTimePicker.date
        
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
    
    

}
