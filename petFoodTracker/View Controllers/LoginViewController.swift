//
//  LoginViewController.swift
//  petFoodTracker
//
//  Created by Haruko Okada on 9/29/20.
//  Copyright © 2020 Haruko Okada. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.borderColor = UIColor(red: 51/225, green: 198/225, blue: 128/225, alpha: 1.0).cgColor
        
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.borderColor = UIColor(red: 51/225, green: 198/225, blue: 128/225, alpha: 1.0).cgColor

        loginButton.layer.cornerRadius = 10
        
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
    }
    
    func validateTextFields() -> String? {
        //check all textfields are filled in
        if emailTextField.text == "" || passwordTextField.text == "" {
            return "空白があります。"
        }
        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validateTextFields()
        
        if error != nil {
            //エラ〜メッセージを表示
            errorMessageLabel.text = error!
        } else {
        //create cleaned version of data

        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Signin the user
            Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                
                if error != nil {
                    //couldn't login
                    self.errorMessageLabel.text = "メールアドレスかパスワードが間違ってます。"
                } else {
                    
                //go to home screen
                self.transitionToHome()
                }
            }

        }
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "MainNavController") 
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
