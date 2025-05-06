//
//  SignUpViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
// SignUpViewController View
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }// end viewDidLoad
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Check password boxes
        if passwordTextField.text == passwordCheckTextField.text{
            // Check other inputs
            if mailTextField.text != "" && passwordTextField.text != ""{
                // Create account on Firebase
                let email = mailTextField.text!
                let password = passwordTextField.text!
                let telephoneNumber = phoneNumberTextField.text!
                // Create user with simple mail-password match.
                
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if error != nil{
                        // If error is not nik show to user.
                        self.errorAlert(title: K.err, message: error!.localizedDescription)
                    }else{
                        // Save data as Collection to Firestore Storage
                        self.saveDataToDB(email: email, telephoneNumber: telephoneNumber)
                        
                        // Alert For Verification of E-Mail
                        let alert = UIAlertController(title: "Verify", message: "Please Verify your E-Mail address for your security.", preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Verify Me!", style: UIAlertAction.Style.default) { action in
                            // get current user to send email
                            let user = Auth.auth().currentUser
                            // Firebase code for sending verification mail.
                            user!.sendEmailVerification()
                            self.verificationAlert(title: "Verify", message: "Please Check Your E - Mail.")
                        }
                        alert.addAction(okButton)
                        self.present(alert, animated: true,completion: nil)
                        
                        }// end else

                    }// end  CreateUser Closure
                
                } // end if mailtext and passwordtext check
            }else{
            // Else of password boxes check
            errorAlert(title: K.err, message: K.errPasswordMessage)
        } // end else
    }// end SignUpTapped
}// end class SignUpViewController
extension SignUpViewController{
    func saveDataToDB(email:String,telephoneNumber:String){
        // Save as User Info Collection at Firestore DB.
        let firestore = Firestore.firestore()
        // Create a loacl collection for send to DB.
        let userInfo = ["user_Mail":email,"phone":telephoneNumber]
        firestore.collection("userInfo").addDocument(data: userInfo as [String:Any]) { error in
            if error != nil{
                self.errorAlert(title: K.err, message: error!.localizedDescription)
            }//end if
        }// end closure
        
    }// end func saveDataToDB
    
    // Custom Alert for E-mail Verification and after that segue to App main View.
    func verificationAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default) { action in
            self.performSegue(withIdentifier: K.Segues.signUpToMain, sender: nil)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
    }// end alert func

}// end extension
