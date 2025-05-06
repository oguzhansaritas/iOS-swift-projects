//
//  LoginVerifyViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth

// SignIn Verify ViewController
class SignInVerifyViewController: UIViewController {

    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    // To catch data from previous ViewController
    var verificationId : String?
    var verificationCode : String?
    var resolver : MultiFactorResolver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }// end viewDidLoad
    
    @IBAction func resendTapped(_ sender: Any) {
    }// Resend Button Tapped func
    
    @IBAction func verifyTapped(_ sender: Any) {
        
        // Verification session with Verification code and Verification ID.
        verificationCode = codeTextField.text
        // Firebase documentation code for checking sms code == verification ID
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationId!,
          verificationCode: verificationCode!)
        let assertion = PhoneMultiFactorGenerator.assertion(with: credential)

        // Complete sign-in.
        resolver!.resolveSignIn(with: assertion) { (authResult, error) in
          if error != nil {
              // if error exist show to user.
              self.errorAlert(title: "Error", message: error!.localizedDescription)
          }else{
              // if error is nil continue to app main view
              self.performSegue(withIdentifier: "LoginToMain", sender: nil)
          }// end else
        }// end resolver completion
    }// end verify Tapped func
}// end SignInVerifyController Class
