//
//  Dog.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/11/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class Dog: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var dogGender: String = ""
    @objc dynamic var others: String = ""

    @objc dynamic private var _dogImage: UIImage? = nil
    
    dynamic var dogImage: UIImage? {
        
        set {
            self._dogImage = newValue
            if let value = newValue {
                self.imageData = value.jpegData(compressionQuality: 0.9)! as Data
            }
        }
        
        get {
            if let image = self._dogImage {
                return image
            }
            
            if let data = self.imageData {
                self._dogImage = UIImage(data: data)
                return self._dogImage
            }
            return nil
        }
    }
    dynamic private var imageData: Data? = nil


    override static func ignoredProperties() -> [String] {
        return ["dogImage", "_dogImage"]
    }

//    override class func primaryKey() -> String? {
//        return "id"
//    }

    
}
