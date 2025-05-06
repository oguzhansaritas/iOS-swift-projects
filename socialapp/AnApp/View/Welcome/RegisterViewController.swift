//
//  RegisterViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

// Creating Account
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        // Check password boxes
        if passwordTextField.text == checkPasswordTextField.text{
            // Check other inputs 
            if emailTextField.text != "" && passwordTextField.text != ""{
                // Create account on Firebase
                let email = emailTextField.text!
                let password = passwordTextField.text!
                
                // Create user with simple mail-password match.
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if error != nil{
                        self.errorAlert(title: K.err, message: error!.localizedDescription)
                    }else{
                        // Save as User Info Collection at Firestore DB.
                        
                        let firestore = Firestore.firestore()
                        // Create a loacl collection for send to DB.
                        let userInfo = ["user_Mail":email]
                        firestore.collection("userInfo").addDocument(data: userInfo as [String:Any]) { error in
                            if error != nil{
                                self.errorAlert(title: K.err, message: error!.localizedDescription)
                            }//end if
                        }// end closure
                        // Direct to the App Main Screen witch is Feed Section for now.
                        self.performSegue(withIdentifier: K.Segue.registerSegue, sender: nil)
                    }// end else
                }// end closure
            }// end if
        }else{
            // Else of password boxes check
            errorAlert(title: K.err, message: K.errPasswordMessage)
        }// end else
    }// end function
}// end Class

