//
//  AddDogViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 10/11/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import RealmSwift

class AddDogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var dataSourceForGender = ["オス","メス"]
    let realm = try! Realm()
    var dog = Dog()

    
    @IBOutlet weak var dogPicture: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var otherText: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    var selectedGender: String!
    
    var defualtDog: UIImage = UIImage(imageLiteralResourceName: "defaultDog")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        otherText.layer.borderWidth = 1
        otherText.layer.borderColor = UIColor.black.cgColor
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        
        //bring keyboard up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dogPicture.image = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        } else {
            print("error")
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataSourceForGender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    
    
    
    @IBAction func saveInfo(_ sender: Any) {
        
        
        try! realm.write {
            
            if otherText.text.isEmpty {
                otherText.text = ""
            }
            
            dog.others = otherText.text!
            dog.dogGender = dataSourceForGender[genderPicker.selectedRow(inComponent: 0)]
            
            if nameText.text != "" {
                dog.name = nameText.text!
                print("name saved")
                if dogPicture.image != nil {
                    
                    dog.dogImage = dogPicture.image!
                    print("dogpic saved") //UIImage
                    
//                    if dog.dogImage is UIImage {
//                        print ("1")
//                    } else if dog.dogImage is Data {
//                        print ("2")
//                    } else if dog.dogImage == nil{
//                        print ("dog.dogimage is nillll")
//                    } else {
//                        print("nani")
//                    }
                } else {
                    dog.dogImage = UIImage(named: "defaultDog")
                    print("defualt pic saved")
                }
                realm.add(dog)
                dismiss(animated: true, completion: nil)
            } else {
                errorMessage.text = "お友達の名前を入れてください"
                print("error")
                
            }
            
            
            print("success?")

        }
        
      
    }
    
    func hideKeyboard() {
        errorMessage.resignFirstResponder()
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
}




