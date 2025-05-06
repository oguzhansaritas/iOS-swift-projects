//
//  ContentView.swift
//  CryptoSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel // to observe
    
    init(){
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    
    var body: some View {
        NavigationView {
            List(cryptoListViewModel.cryptoList,id:\.id){ crypto in
                VStack{
                    Text(crypto.currency).font(.title3).foregroundColor(.blue).frame(maxWidth : .infinity,alignment:.leading)
                    Text(crypto.price).foregroundColor(.black).frame(maxWidth : .infinity,alignment:.trailing)
                }// end Vstack
            }.toolbar(content: {
                Button {
                    // Button func
                    /*
                     
                    Old way
                    
                    async{
                        await cyrptoListViewModel.downloadCryptosContinuation(url:URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                     */
                    
                    Task.init {
                        //self.cyrptoListViewModel.cryptoList = []
                        await cryptoListViewModel.downloadCryptosContinuation(url:URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                    
                    
                    
                    
                } label: {
                    //Button type
                    Text("Refresh")
                }

            })
            
            .navigationTitle("Crypto!")// end completion
        }.task {
            
            
            // when using escaping with continuation
            
            await cryptoListViewModel.downloadCryptosContinuation(url:URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
            /*
            when using async func
             
             
            await cyrptoListViewModel.getCryprosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
             */
        }
        
        
        
        /*.onAppear{
            
         when using escaping
            
            //Old Technology
            //cyrptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
