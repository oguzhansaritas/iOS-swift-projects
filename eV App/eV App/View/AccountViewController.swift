//
//  AccountViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
// Account View

class AccountViewController: UIViewController {
    
    // Personal Info
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var telephoneTextField: UITextField!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    // Car Info
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carBrandTextField: UITextField!
    @IBOutlet weak var carModelTextField: UITextField!
    
    @IBOutlet weak var carYearTextField: UITextField!
//    Get current user info
    let user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        // Control to MFA is on. WE need to reload user information to app.
        checkMultiFactor()
        
    }// end viewDidLoad
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Check user email is verified or not. &&  Is MFA enrolled factors exist?
        checkMultiFactor()
    }// end viewWillAppear
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        // Firebase Documentation code for Sign Out.
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // Send back to welcomeVC after signing out.
            performSegue(withIdentifier: "toWelcomeVC", sender: nil)
        } catch let signOutError as NSError {
            self.errorAlert(title: "Error", message: signOutError.localizedDescription)
        }// end catch
        
    }// end logOutButtonPressed Function
    
    

}// end AcoountViewController Class

extension AccountViewController{
    // Custom alert for return to TabBar
    func verificationlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Let's Go!", style: UIAlertAction.Style.default) { action in
            self.performSegue(withIdentifier: "toVerificationCenter", sender: nil)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
    }// end func
    
    func checkMultiFactor(){
        // Check user email is verified or not. &&  Is MFA enrolled factors exist?
        if let user = Auth.auth().currentUser{
            user.reload()
            if user.isEmailVerified && user.multiFactor.enrolledFactors.isEmpty{
                verificationlert(title: "Verification Alert!", message: "Multi Factor Authentication is a must for our platform. Just Do It!")
            }
        }else{
            // todo email verification alert
        }//end else
    }// end function
}// end extension
