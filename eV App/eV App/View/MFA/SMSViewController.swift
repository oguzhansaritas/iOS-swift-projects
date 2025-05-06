//
//  SMSViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS .
//

import UIKit
import FirebaseAuth
// SMS Code Verification ViewController
class SMSViewController: UIViewController {
    var window: UIWindow?
    
    @IBOutlet weak var smsCodeTextField: UITextField!
    // Variables for to catch data previous ViewController
    var verificationID = ""
    var verificationCode = ""
    //Get current user to 'user' variable for cleaner view.
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }// end viewDidLoad
    
    
    @IBAction func verifyTapped(_ sender: Any) {
        // Take Verification code from user from textField input.
        verificationCode = smsCodeTextField.text!
        
        // Firebase Phone Authentication pre-prepared code from documentation.
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode)
        let assertion = PhoneMultiFactorGenerator.assertion(with: credential)
        // Complete enrollment. This will update the underlying tokens
        // and trigger ID token change listener.
        
        // Enroll to activate 2 steps aka Multi Factor Authentication.
        user?.multiFactor.enroll(with: assertion,displayName: "") { (error) in
            //If does not exist error then Enrollment is succesfully complete.
            if error == nil{
                
                // Create Alert to inform user.
                let alert = UIAlertController(title: "Success.", message: "You can login into your account with Multi Factor Authentication.", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default) { action in
                    // When press to OK button, send to the app main.
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }// end okButton completion
                
                // Add action to Alert Controller
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
            }
            // If error exist, alert function will appear on UI.
            else{
                self.errorAlert(title: "Some Error", message: error!.localizedDescription)
            }// end else
        }// end of multifactor Completion
    }// end VerifyTapped func
}// end ViewController
