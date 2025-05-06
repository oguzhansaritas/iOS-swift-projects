//
//  Constants.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
import FirebaseAuth

struct K {
    struct Segues{
        static let loginToMain = "LoginToMain"
        static let signUpToMain = "SignUpToMain"
        static let signUpToVerify = "SignUpToVerify"
        static let signInToVerify = "SignInToVerify"
        
    }
    static let locationsURL = "https://raw.githubusercontent.com/observer23/newsApi/main/UK.geojson" //static
    static let err = "Error"
        static let errPasswordMessage = "Please check your password."
        static let errLoginMessage = "Please check your Mail or Password."
}

// For InApp First telephone number verification
struct UserMFAInfo{
    var verificationID:String?
    var phoneNumber:String?
}

// For SignIn Verification 
struct dataToSend{
    var verificationId = String()
    var resolver = MultiFactorResolver()
}

