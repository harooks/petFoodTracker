//
//  HomeViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 9/29/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ask for notification permission
        let center = UNUserNotificationCenter.current()
    
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in

        }
        
//        //create notification content
//        let content = UNMutableNotificationContent()
//        content.title = "Hello world"
//        content.body = "u just got a notification"
//
//        //create notification trigger
//        let date = Date().addingTimeInterval(10)
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        //create request
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//
//        //register request
//        center.add(request) { (error) in
//            //check the error parameter and hadle any errors
//        }
    }
    
}
