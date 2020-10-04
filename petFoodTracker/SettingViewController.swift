//
//  SettingViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/3/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingTable: UITableView!
    
    let notificationSwitch = UISwitch()
    
    var mySections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTable.delegate = self
        settingTable.dataSource = self
    
        mySections = ["通知","時間"]

        settingTable.register(TimeTableViewCell.nib(), forCellReuseIdentifier: TimeTableViewCell.identifier)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        if indexPath.section == 0 {
            let switchCell = settingTable.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath)
 
        
        switchCell.textLabel?.text = "通知をオンにする"
        switchCell.accessoryView = notificationSwitch

        return switchCell
        } else {
            let timeCell = settingTable.dequeueReusableCell(withIdentifier: TimeTableViewCell.identifier, for: indexPath) as! TimeTableViewCell
            
            let selectedTime = saveTime.object(forKey: "breakTime")
            
            timeCell.configure(with: "asagohann", time: selectedTime as! Date)
            
            return timeCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "通知"
        } else {
            return "時間"
        }
     }
        
    
    
}
