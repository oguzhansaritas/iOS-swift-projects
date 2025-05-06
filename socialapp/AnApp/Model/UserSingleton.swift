//
//  UserSingleton.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

class UserSingleton{
    
    static let sharedUserInfo = UserSingleton()
    var email = ""
    var username = ""
    private init(){}
}
