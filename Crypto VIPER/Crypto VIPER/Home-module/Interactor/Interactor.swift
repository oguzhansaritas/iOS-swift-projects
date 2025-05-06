//
//  Interactor.swift
//  Crypto VIPER
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

// Interacts with Presenter
//

protocol AnyInteractor{
    var presenter: AnyPresenter?{get set}
    
    func downloadCryptos()
    
}

class CryptoInteractor:AnyInteractor{
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data , error == nil else{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                // sending presenter to info
                return
            }
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
                // sending presenter to info
            }catch{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
                // sending presenter to info
            }// end catch
        }// end completion
        
        task.resume()
    }// end function
    
    
}// end class
