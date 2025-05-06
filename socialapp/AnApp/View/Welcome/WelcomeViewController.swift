//
//  ViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import CLTypingLabel
class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // Getting random Welcome Message from Array and display with animation
        
        welcomeLabel.text = K.welcomeMessage.randomElement()
    }


}

