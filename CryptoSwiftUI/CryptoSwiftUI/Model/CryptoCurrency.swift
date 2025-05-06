//
//  CryptoCurrency.swift
//  CryptoSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


struct CryptoCurrency : Hashable,Decodable,Identifiable{
    
    let id = UUID()
    
    var currency:String
    var price:String
    
    private enum CodingKeys : String,CodingKey{
        case currency = "currency"
        case price = "price"
        
        
    }
    
}
