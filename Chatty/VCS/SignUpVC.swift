//
//  SignUpVC.swift
//  Chatty
//
//  Created by Deniz Dilbilir on 02/10/2023.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
    
    
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let crashy = error {
                    print(crashy.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: Constants.signUpConnect, sender: self)
                }
            }
        }
    }

}
