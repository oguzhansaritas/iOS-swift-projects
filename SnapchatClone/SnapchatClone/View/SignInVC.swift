//
//  ViewController.swift
//  SnapchatClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Firebase

// UI View Controller what ... command
//

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func signInButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            let auth = Auth.auth()
            auth.signIn(withEmail: emailTextField.text!,password: passwordTextField.text!) { result, error in // Firebase - Sign In auto-code
                if error != nil {
                    self.errorAlert(title: "Error", message: error!.localizedDescription)
                    // Firebase error messeage
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if emailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != ""{
            let auth = Auth.auth()
            auth.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { auth, error in   // Firebase auth automatic create code
                if error != nil {
                    self.errorAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else{
                    
                    let firestore = Firestore.firestore()
                    let userInfo = ["email":self.emailTextField.text,"username":self.usernameTextField.text] // User information Dictionary
                    
                    firestore.collection("UserInfo").addDocument(data: userInfo as [String : Any]) { error in
                        print(error?.localizedDescription ?? "Error.")
                        // Firebase- For Create Collection and add document
                    }
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            errorAlert(title: "Error", message: "Username/E-Mail/Password is empty. ")

            
        }//end else if
        
    } // end button func
} // end class

extension SignInVC{
    func errorAlert(title:String,message:String){
               let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
               
               let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
               alert.addAction(okButton)
               self.present(alert, animated: true,completion: nil)
               
           }// end error func
}// end ext

