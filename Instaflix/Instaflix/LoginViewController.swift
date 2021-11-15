//
//  LoginViewController.swift
//  Instaflix
//
//  Created by Edgar Bermudez on 11/11/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
        override func viewDidAppear(_ animated: Bool) {
            if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
        }
    
    @IBAction func onLogIn(_ sender: Any) {
        
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    

    
    @IBAction func onSignUp(_ sender: Any) {
        
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        let alertController = UIAlertController(title: "Account Created", message: "The account has been created", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        user.signUpInBackground { (success, error) in
            if success {
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
}
