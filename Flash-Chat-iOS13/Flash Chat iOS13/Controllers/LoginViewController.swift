
import UIKit
import Firebase

//Login View

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        // Checking mail or password is not empty
        if let email = emailTextfield.text , let password = passwordTextfield.text{
            // Firebase Login with auto code
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil{
                    self.errorAlert(title: "Opss..", message: error!.localizedDescription)
                    //print(error!.localizedDescription)
                    // can be pop-up or alert
                }else{
                    //print("Succesfull.")
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }// end else
            }// end closure
        }// end if
        
        
    }// end button
    
}// end class

extension LoginViewController{
    func errorAlert(title:String,message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
                
            }
}
