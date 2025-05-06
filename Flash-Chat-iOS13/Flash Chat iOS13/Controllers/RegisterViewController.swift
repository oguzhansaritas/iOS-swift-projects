

import UIKit
import Firebase
// Register View
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        // Checking E-mail or password is not empty
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            // Firebase creating user with auto - code
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error{
                    self.errorAlert(title: "Opss..", message: error.localizedDescription)
                    //print(error)
                    // can be pop-up or alert
                }else{
                    //print("Successfully Registered.")
                    // can be pop-up or alert
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }// end else
            }// end closure
        }//end if
        
        
    }// end func
    
}// end class

extension RegisterViewController{
    func errorAlert(title:String,message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
                
            }
}
