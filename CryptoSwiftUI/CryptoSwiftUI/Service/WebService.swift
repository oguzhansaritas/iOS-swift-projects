//
//  WebService.swift
//  CryptoSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


class WebService{
    
    /*
    // gettting data with async await
     
     
    func getCryptoDataAsync(url:URL) async throws-> [CryptoCurrency]{ // if you use "async throws", you can handle the error where u use func
        let (data,_) = try await URLSession.shared.data(from: url)
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        return currencies ?? []
    }
    
    */
    // getting data with Continuation
    
    func getCurrencyDataContinuation(url:URL) async throws -> [CryptoCurrency]{
        
        try await withCheckedThrowingContinuation { continuation in
            getData(url: url) { result in
                switch result{
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error)
                }// end switch
            }// end completion
        }// end try completion
        
    }
    
    
    
    
    
    
    
    
    
    /* OLD TECHNOLOGY
     getting data with @escaping
     */
    func getData(url:URL, completion : @escaping(Result<[CryptoCurrency]?,DownloaderError>)->Void){
        // @escaping ----->>>>>> when process is done return some data
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
                completion(.failure(.URLWrong))
            }//end if
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        }// end completion
        .resume()
        
    }
     
}


enum DownloaderError : Error{
    case URLWrong
    case noData
    case dataParseError
}
