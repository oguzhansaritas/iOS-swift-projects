//
//  ResetViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth

// Password Reset VC 
class ResetViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func sendbuttonPressed(_ sender: Any) {
        let auth = Auth.auth()
        //Check mail box isEmpty
        if emailTextField.text != ""{
            // Send link to Email from Firebase
            auth.sendPasswordReset(withEmail: emailTextField.text!) { error in
                if error != nil{
                    self.errorAlert(title: K.err, message: error!.localizedDescription)
                }else{
                    self.errorAlert(title: "Great!", message: "You can check your mailbox for reset your password.")
                }// end else
            }//end closure
        }// end if
        else{
            self.errorAlert(title: K.err, message: K.errLoginMessage)
        }//end else
    }//end button function
    
}//end class
