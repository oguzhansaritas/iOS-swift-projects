//
//  View.swift
//  Crypto VIPER
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
import UIKit
// Interacts with Presenter
// View Controller


protocol AnyView{
    var presenter : AnyPresenter?{get set}
    
    func update(with cryptos: [Crypto])
    func update(with error : String)
}

class DetailViewController : UIViewController{
    var currency : String = ""
    var price : String = ""
    private let currencyLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Currency Label."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(currencyLabel)
        view.addSubview(priceLabel)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        currencyLabel.frame = CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50)
        priceLabel.frame = CGRect(x: view.frame.width/2-100, y: view.frame.height/2+50, width: 200, height: 50)
        
        currencyLabel.text = currency
        priceLabel.text = price
        
        currencyLabel.isHidden = false
        priceLabel.isHidden = false
    }
}

class CryptoViewController: UIViewController, AnyView, UITableViewDelegate,UITableViewDataSource{
    

    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messeageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Loading...."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var cryptoList = [Crypto]()
    var presenter: AnyPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messeageLabel)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messeageLabel.frame = CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50)
    }
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptoList = cryptos
            self.messeageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        //
        DispatchQueue.main.async {
            self.cryptoList = []
            self.tableView.isHidden = true
            self.messeageLabel.text = error
            self.messeageLabel.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .yellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.currency = cryptoList[indexPath.row].currency
        nextVC.price = cryptoList[indexPath.row].price
        self.present(nextVC, animated: true)
    }
    

    
    
}
