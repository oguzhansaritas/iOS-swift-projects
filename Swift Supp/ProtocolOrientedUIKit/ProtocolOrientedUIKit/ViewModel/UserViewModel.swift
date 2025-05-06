//
//  UserViewModel.swift
//  ProtocolOrientedUIKit
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

class UserViewModel{
    
    private let userService:UserService
    
    weak var output:UserViewModelProtocol?
    
    init(userService: UserService) {
        self.userService = userService
    }
    func getUsers(){
        userService.fetchUser { [weak self]result in
            switch result{
            case .success(let user):
                self?.output?.updateView(name: user.name, username: user.username, email: user.email)
            case .failure(_):
                self?.output?.updateView(name:"No User", username: "", email: "")
                
            }
        }
        
    }
}
