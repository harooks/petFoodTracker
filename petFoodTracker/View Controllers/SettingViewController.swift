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

        let switchCell = settingTable.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath)
        
        switchCell.textLabel?.text = "通知をオンにする"
        
        notificationSwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
        notificationSwitch.isOn = true
        switchCell.accessoryView = notificationSwitch
        
        return switchCell
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            print("User turned it on")
        } else {
            print("it is  now off")
        }
}
    

}
    
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }





