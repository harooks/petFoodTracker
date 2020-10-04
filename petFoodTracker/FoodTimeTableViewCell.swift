//
//  FoodTimeTableViewCell.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 9/30/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit


class FoodTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var foodTimeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!

        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func timePickerChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let timeString = dateFormatter.string(from: (sender as AnyObject).date)
        
        timeLabel.text = timeString
        
    
        //print(Date())
    }


    
    

    
    
}
