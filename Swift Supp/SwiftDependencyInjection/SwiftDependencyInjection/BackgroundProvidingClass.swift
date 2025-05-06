//
//  BackgroundProvidingClass.swift
//  SwiftDependencyInjection
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
import UIKit

class backgroundProvidingClass:BackgroundColorProviderProtocol{
    var backgroundColor: UIColor{
        let backgroundColors : [UIColor] = [.gray,.cyan,.blue,.black]
        return backgroundColors.randomElement()!
    }
    
    
}
