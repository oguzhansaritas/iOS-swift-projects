//
//  ViewController.swift
//  ProtocolOrientedUIKit
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class UserVC: UIViewController,UserViewModelProtocol {
    
    
    func updateView(name: String, username: String, email: String) {
        self.nameLabel.text = name
        self.usernameLabel.text = username
        self.emailLabel.text = email
    }
    
    
    private let viewModel : UserViewModel
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Labels With Code
    private let nameLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    private let usernameLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    private let emailLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getUsers()
        
        
        
        
        
        
    }
    func setupViews(){
        view.backgroundColor = .cyan
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate(
        [
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 60),
            usernameLabel.widthAnchor.constraint(equalToConstant: 200),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 60),
            emailLabel.widthAnchor.constraint(equalToConstant: 200),
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,constant: 5),
        ]
        )
    }
    
    /*
    private func getUsers(){
        APIManager.shared.fetchUser { result in
            switch result{
            case .success(let user):
                self.nameLabel.text = user.name
                self.usernameLabel.text = user.username
                self.emailLabel.text = user.email
            case .failure(let error):
                self.nameLabel.text = "NEtwork Error\(error)"
            }
        }
    }
     */


}

