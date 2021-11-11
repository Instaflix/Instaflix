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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func onLogIn(_ sender: Any) {
        
        
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
