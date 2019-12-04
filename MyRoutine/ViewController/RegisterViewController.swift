//
//  RegisterViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/5/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var goBackLogin: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var passwordRegisterTextField: UITextField!
    @IBOutlet weak var emailRegisterTextField: UITextField!
    
    @IBOutlet weak var reTypePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackLogin.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        if passwordRegisterTextField.text != reTypePasswordTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: emailRegisterTextField.text!, password: passwordRegisterTextField.text!){ (user, error) in
                if error == nil {
                    self.backButtonPressed()
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    

}
