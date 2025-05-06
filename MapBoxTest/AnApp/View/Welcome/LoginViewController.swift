//
//  LoginViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import LocalAuthentication
// Login with Your Account


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
    @IBAction func rememberSwitch(_ sender:UISwitch) {
        if sender.isOn{
            UserDefaults.standard.set(true, forKey: "Remember")
        }
    }
    */
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        // Go to Password Reset VC
        performSegue(withIdentifier: K.Segue.resetPaswordSegue, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let auth = Auth.auth()
        // Check inputs
        if emailTextField.text != "" && passwordTextField.text != ""{
            // Login account on Firebase
            let email = emailTextField.text!
            let password = passwordTextField.text!
            // Access to Firebase with auto-code
            auth.signIn(withEmail: email, password: password) { _, error in
                if error != nil{
                    self.errorAlert(title: K.err, message: error!.localizedDescription)
                }else{
                    // If login is succesfull, direcct to the App Main View whic is Feed for now.
                    self.localAuth()
                    //without localAuth uncomment next line
                    //self.performSegue(withIdentifier: K.Segue.loginSegue, sender: nil)
                }// end else
            }// end closure
        }// end Check Inputs
        else{
            self.errorAlert(title: K.err, message: K.errLoginMessage)
        }// end else
    }// end login button
}// end class

extension LoginViewController{
    // Local Authentication code with Biometry from Swift Documentation
    func localAuth(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        // if success then continue to Feed VC.
                        self!.performSegue(withIdentifier: K.Segue.loginSegue, sender: nil)
                    } else {
                        // error
                        let ac = UIAlertController(title: "Authentication failed.", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self!.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}
