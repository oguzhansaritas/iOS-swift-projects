//
//  WebService.swift
//  Crypto MVVM
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

//Web service for getting data from API

class WebService{
    
    func getCurrencies(url:URL,completion:@escaping ([CryptoCurrency]?)->()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // UrlSession calling
            if let error = error{
                print(error.localizedDescription)
                completion(nil)
            }else if let data=data{
               
                    let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                // JSON Decoding
                    if let cryptoList = cryptoList{
                        completion(cryptoList)
                    }
                                    
            }
        }.resume()
    }
}
