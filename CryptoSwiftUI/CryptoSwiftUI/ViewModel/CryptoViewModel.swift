//
//  CryptoViewModel.swift
//  CryptoSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

@MainActor  // functions of this class  will be on Main Thread


class CryptoListViewModel : ObservableObject{
    
    @Published var cryptoList = [CryptoViewModel]() // we can observe another place with ObservableObject
    
    let webService = WebService()
    
    func downloadCryptosContinuation(url:URL) async{
        do{
            let cryptos = try await webService.getCurrencyDataContinuation(url: url)
            self.cryptoList = cryptos.map(CryptoViewModel.init)
            /*
             when using @MainActor , dont need dispatchqueue
             
             
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }// end dispatchqueue
             */
        }catch{
            print(error.localizedDescription)
        }// end catch
    }// end function
    
    
    /*
    func getCryprosAsync(url:URL) async{
        do{
            let cryptos = try await webService.getCryptoDataAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        }catch{
            print(error)
        }
     */
        
    }
    
    /*
    func downloadCryptos(url:URL){
        webService.getData(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cryptos):
                if let cryptos = cryptos{
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    } // end async
                    
                }// end if
            }// end switch case
        }// end completion
    }// end function
     
     
}// end class
*/

struct CryptoViewModel{
    let crypto : CryptoCurrency
    
    var id : UUID?{
        crypto.id
    }
    var currency : String{
        crypto.currency
    }
    var price : String{
        crypto.price
    }
    
    
    
}
