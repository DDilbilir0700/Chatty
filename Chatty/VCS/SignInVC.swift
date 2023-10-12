//
//  SignInVC.swift
//  Chatty
//
//  Created by Deniz Dilbilir on 02/10/2023.
//


import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    @IBAction func signInPressed(_ sender: UIButton) {
    
    if let email = emailTextField.text, let password = passwordTextField.text {          
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let crashy = error {
                    print(crashy.localizedDescription)
                } else {
                    self?.performSegue(withIdentifier: Constants.signInConnect, sender: self)
                }
            }
        }
    }
    
}
