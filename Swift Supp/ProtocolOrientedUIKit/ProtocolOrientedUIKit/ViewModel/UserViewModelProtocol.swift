//
//  UserViewModelProtocol.swift
//  ProtocolOrientedUIKit
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


protocol UserViewModelProtocol:AnyObject{
    func updateView(name:String,username:String,email:String)
}
