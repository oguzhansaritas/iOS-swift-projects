//
//  LoginStorageService.swift
//  LoginCheck
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


protocol LoginStorageServiceProtocol{
    var userAccessTokenKey : String{get}
    func setUserAccessToken(token:String)
    func getUserAccessToken()->String?
}
