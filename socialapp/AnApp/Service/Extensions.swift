//
//  Extensions.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
import UIKit

// General use extensions


extension UIViewController{
    // with this extension we can reach the  errorAlert function from all ViewControllers
    func errorAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
    }
}
