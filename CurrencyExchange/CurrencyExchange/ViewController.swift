//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chflabel: UILabel!
    @IBOutlet weak var gbplabel: UILabel!
    @IBOutlet weak var trylabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRates(_ sender: Any) {
        
        // Request & Session
        // Reponse & Data
        // Parsing & Serialization
        
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okbutton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okbutton)
                self.present(alert, animated: true)
            }else{
                if data != nil{
                
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String,Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String:Any]{
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD:\(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chflabel.text = "CHF:\(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbplabel.text = "GBP:\(gbp)"
                                }
                                if let tl = rates["TRY"] as? Double{
                                    self.trylabel.text = "TRY:\(tl)"
                                };if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD:\(usd)"
                                }
                                
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
    
}

