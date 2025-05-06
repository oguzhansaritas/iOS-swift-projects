//
//  ViewController.swift
//  Crypto MVVM
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var cryptoTableView: UITableView!
    
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cryptoTableView.delegate = self
        cryptoTableView.dataSource = self

        self.colorArray = [UIColor(red: 75/255, green: 57/255, blue: 204/255, alpha: 1),UIColor(red: 15/255, green: 27/255, blue: 100/255, alpha: 1)]
        getData()
        
    }
    func getData(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        // fixed url
        WebService().getCurrencies(url: url!) { cryptos in
            if let cryptos = cryptos{
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async { // Async
                    self.cryptoTableView.reloadData()
                }// end async
            }//end if
        }// end completion
    }// end func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cryptoTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CryptoCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoPathIndex(indexPath.row)
        cell.currencyNameLAbel.text = cryptoViewModel.name
        cell.currencyRateLabel.text = cryptoViewModel.price
        cell.currencyRateLabel.textColor = .white
        cell.currencyNameLAbel.textColor = .white
        cell.backgroundColor = self.colorArray[indexPath.row % 2]
        
        return cell
    }
    



}

