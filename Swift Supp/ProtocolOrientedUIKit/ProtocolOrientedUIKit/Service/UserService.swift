//
//  UserService.swift
//  ProtocolOrientedUIKit
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
protocol UserService{
    func fetchUser(completion : @escaping(Result<User,Error>)->Void)
}
