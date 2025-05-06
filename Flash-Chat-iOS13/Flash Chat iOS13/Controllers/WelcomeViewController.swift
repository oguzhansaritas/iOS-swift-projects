

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
        
        
        // ---- To make animation to label without External Package
        /*
        titleLabel.text = ""
        var charIndex = 0
        let titleText = "⚡️FlashChat"
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1*Double(charIndex), repeats: true) {  timer in
                self.titleLabel.text?.append(letter) // for getting animation effect
            }
            charIndex += 1
            
        }*/
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    

}
