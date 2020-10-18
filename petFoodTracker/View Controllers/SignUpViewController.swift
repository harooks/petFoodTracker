//
//  SignUpViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 9/29/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


let db = Firestore.firestore()

class SignUpViewController: UIViewController {
    

    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor(red: 51/225, green: 198/225, blue: 128/225, alpha: 1.0).cgColor
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.borderColor = UIColor(red: 51/225, green: 198/225, blue: 128/225, alpha: 1.0).cgColor
        
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.borderColor = UIColor(red: 51/225, green: 198/225, blue: 128/225, alpha: 1.0).cgColor
        
        Messaging.messaging().retrieveFCMToken(forSenderID: "44383939358", completion: { (token, error) in
            if let error = error {
              print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
              print("FCM registration token: \(token)")
              //self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
            }
        })
        
    }
    
    //textfield を確認
    func validateTextFields() -> String? {
        //check all textfields are filled in
        if emailTextField.text == "" || passwordTextField.text == "" {
            return "空白があります。"
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {

        
        
        let error = validateTextFields()
        
        if error != nil {
            //エラ〜メッセージを表示
            showError(error!)
        } else {
            
            // create cleaned versions of data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //user created successfully. Save data in firestore
                
                db.collection("users").document(result!.user.uid).setData(["email": email, "password": password, "didGiveBreakfast": false, "didGiveDinner": false, "uid": result!.user.uid])
                
                if error != nil {
                    print("error saving data")
                }
                
                //transition to home screen
                self.transitionToHome()
                
                
            }
            
        }
    }
    
    func showError(_ message: String){
        errorMessageLabel.text = message
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "MainNavController")
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
    
    //self.navigationController?.pushViewController(newViewController, animated: true)
}
