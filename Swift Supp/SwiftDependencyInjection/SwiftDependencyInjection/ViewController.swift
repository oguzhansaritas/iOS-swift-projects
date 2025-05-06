//
//  ViewController.swift
//  SwiftDependencyInjection
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Swinject
class ViewController: UIViewController {

    
    // Swinject
    
    
    var container : Container {
        let container = Container()
        container.register(backgroundProvidingClass.self) { resolver in
            return backgroundProvidingClass()
        }
        container.register(SecondVc.self) { resolver in
            let vc = SecondVc(providerProtocol: resolver.resolve(backgroundProvidingClass.self))
            return vc
        }
        return container
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        view.backgroundColor = .blue
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        button.setTitle("Open other VC", for: .normal)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    @objc private func buttonClicked(){
        if let viewController = container.resolve(SecondVc.self){
            present(viewController, animated: true)
        }
    }


}

