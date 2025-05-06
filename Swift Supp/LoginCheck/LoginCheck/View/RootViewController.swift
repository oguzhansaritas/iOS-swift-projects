//
//  ViewController.swift
//  LoginCheck
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class RootViewController: UIViewController,RootViewModelProtocol {

    
    private let viewModel : RootViewModel
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        viewModel.checkLogin()
    }

    
    func showMainApp(){
        let mainviewcontroller = MainViewController()
        navigationController?.present(mainviewcontroller,animated: true)
    }
    func showLogin(){
        let loginviewcontroller = LoginViewController()
        navigationController?.present(loginviewcontroller,animated: true)
    }



}

