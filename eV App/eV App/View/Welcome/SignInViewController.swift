//
//  SignInViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
// Sign In View Controller

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    // Create needed  variables
    let user = Auth.auth().currentUser
    var phoneNumber : String?
    var verificationCodeFromUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        // Check inputs
        if emailTextField.text != "" && passwordTextField.text != ""{
            // Login account on Firebase
            let email = emailTextField.text!
            let password = passwordTextField.text!
            // Call Sign In MFA Function to start session
            signWithMFA(email: email, password: password, phoneNumber: getUserInfo(email: email))
        }// end if
    }// end signInTapped func
}// end SignIn ViewController

extension SignInViewController{
    // To get user Telephone Number from FirebaseFirestore Database
    func getUserInfo(email:String)->String{
        var telephoneNumber  = ""
        // call the database
        let db = Firestore.firestore()
        let currentUser = email
        // Find the account owners field
        db.collection("userInfo").whereField("user_Mail", isEqualTo: currentUser).getDocuments { snapshot, error in
            if error != nil{
                // Check Error
                print("Error.")
            }else{
                // Take User Info and Paste textfields
                for document in snapshot!.documents{
                    telephoneNumber = (document.get("phone") as? String)!
                }//end for
            }//end else
        }// end closure
        return telephoneNumber
    }// end func
    
    
    // func of starting to process
    func signWithMFA(email:String,password:String,phoneNumber:String){
        // Firebase documentation code to process
        Auth.auth().signIn(
          withEmail: email,
          password: password
        ) { (result, error) in
          let authError = error as NSError?
          if authError?.code == AuthErrorCode.secondFactorRequired.rawValue {
            let resolver =
              authError!.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
            // Then:
            let selectedIndex = 0 // We have just 1 choice for MultiFactor for now.
            let hint = resolver.hints[selectedIndex] as! PhoneMultiFactorInfo

            // Send SMS verification code
            PhoneAuthProvider.provider().verifyPhoneNumber(
              with: hint,
              uiDelegate: nil,
              multiFactorSession: resolver.session
            ) { (verificationId, error) in
              if error != nil {
                // Failed to verify phone number.
                  self.errorAlert(title: "Error", message: error!.localizedDescription)
              }else{
                  // If error is nil, then we can continue to sms verification page with needed variables.
                  let data = dataToSend(verificationId: verificationId!,resolver: resolver)
                  self.performSegue(withIdentifier: "SignInToVerify", sender: data)
                  
              }// end else
            }// end PhoneAuthProvider Completion
          }// end if authError?.code condition
        }// end Auth.signIn() completion
    }// end MFA Func
    
    
    // To preparetion of segue with variables.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueData = sender as? dataToSend
            else { return }
            if let destinationVC = segue.destination as? SignInVerifyViewController {
                destinationVC.resolver = segueData.resolver
                destinationVC.verificationId = segueData.verificationId
                }// end if
    }// end prepare func
}// end SignInViewController
