//
//  DatePickerTableViewCell.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/1/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import SwiftUI

class DatePickerTableViewCell: UITableViewCell {
    
        
        @State private var foodTime = Date()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
