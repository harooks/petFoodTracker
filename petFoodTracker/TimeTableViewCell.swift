//
//  TimeTableViewCell.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/3/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var titleLabel: UILabel!
    
    static let identifier = "TimeCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, time: Date) {
        titleLabel.text = title
        timePicker.date = time
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func selectTime(_ sender: Any) {
        
        //set notification for breakfast time
        let content = UNMutableNotificationContent()
        content.title = "ペットの朝ごはんの時間です"
        content.subtitle = "お腹すいたよ〜"
        let triggerTime = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)
        
        let notificationReq = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
        
        
        //save chosen time in Userdefaults
        saveTime.setValue(Date(), forKey: "breakfastTime")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
