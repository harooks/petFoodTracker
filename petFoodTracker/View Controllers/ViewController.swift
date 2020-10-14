//
//  ViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 7/9/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var newAccount: UIButton!
    
    @IBOutlet weak var login: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newAccount.layer.cornerRadius = 10
        newAccount.layer.borderWidth = 3
        newAccount.layer.borderColor = UIColor(red: 51/225, green: 198/225, blue: 128/225, alpha: 1.0).cgColor
        login.layer.cornerRadius = 10
 
        
    }


}

