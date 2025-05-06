//
//  MultiFactorAuthViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

// MultiFactor Authentication CEnter View Controller

class MultiFactorAuthViewController: UIViewController {
    // Create needed variables
    var phone : String?
    var email : String?
    lazy var verificationID = ""
    lazy var verificationCode = ""
    let user = Auth.auth().currentUser
    @IBOutlet weak var codeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }// end viewDidLoad.
    
    @IBAction func sendSMSTapped(_ sender: Any) {
        // Call MFA func to begin process.
        checkMFAisOn(phoneNumber:codeTextField.text!)
    }// end sendSMSTapped function.
    
    func checkMFAisOn(phoneNumber:String){
        // Begşn to multifactor session with Firebase documentation code
        self.user?.multiFactor.getSessionWithCompletion({ (session, error) in
            // Send SMS verification code.
            PhoneAuthProvider.provider().verifyPhoneNumber(
                phoneNumber,
                uiDelegate: nil,
                multiFactorSession: session
            ) { (verificationId, error) in
                // verificationId will be needed for enrollment completion.
                // if error is nil we can continue to sms verification section with verificatiınID variable.
                if error == nil{
                let data = UserMFAInfo(verificationID: verificationId,phoneNumber: phoneNumber)
                self.performSegue(withIdentifier: "toSMSVerify", sender: data)
                    
                }
                // If error exist, show to user as Alert!
                else{
                    self.errorAlert(title: "Error", message: error!.localizedDescription)
                }// end else
                
            }// end PhoneAuthProvider completion
        })// end session completion
        
    }// end checkMFAisOn func
    
    
    // preparation of segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSMSVerify"{
            if let destinationVC = segue.destination as? SMSViewController {
                let data = sender as? UserMFAInfo
                print("Burassssssaaaa:\(data?.phoneNumber ?? "default")")
                destinationVC.verificationID = (data?.verificationID as? String)!
            }// end if
        }// end if
    }// end prepare func
}// end MultiFactorAuthViewController class
