//
//  SettingViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 9/29/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingTable: UITableView!
    
    var foodTimeTableViewCell: FoodTimeTableViewCell?
    
    let notificationSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.delegate = self
        settingTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //switch cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath)
        
        cell.textLabel?.text = "通知をオンにする"
        
        notificationSwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
        notificationSwitch.isOn = true
        cell.accessoryView = notificationSwitch
        
        //datePicker cell
        if indexPath.row > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath)
            foodTimeTableViewCell = cell as? FoodTimeTableViewCell
            
            if indexPath.row == 1 {
                    foodTimeTableViewCell?.foodTimeLabel.text = "朝ごはんの時間"
            } else {
                foodTimeTableViewCell?.foodTimeLabel.text = "夜ごはんの時間"
            }
            return cell
        }
        
        return cell
    }

    @objc func didChangeSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            print("User turned it on")
        } else {
            print("it is  now off")
        }
    }
    
    
    //notification stuff
//    func scheduleNotification() {
//        let content = UNMutableNotificationContent() //The notification's content
//        content.title = "Hi there"
//        content.sound = UNNotificationSound.default
//
//
//        let dateComponent = time?.calendar.dateComponents([.hour, .minute], from: time!.date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
//
//        let notificationReq = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
//    }
//
    
    





}
