//
//  ViewController.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Firebase
class LandpageVC: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let auth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButton(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != ""{
            auth.signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!){ authDataResult, error in
                if error != nil{
                    self.errorAlert(title: "Error", message: error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            errorAlert(title: "Error", message: "Username/password" )
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != ""{
            auth.createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!){ authDataResult, error in
                if error != nil{
                    self.errorAlert(title: "Error", message: error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }else{
            errorAlert(title: "Error", message: "Username/password" )
        }
    }
    
    func errorAlert(title:String,message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true,completion: nil)
            
        }
}

