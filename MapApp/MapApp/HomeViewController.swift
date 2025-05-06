//
//  HomeViewController.swift
//  MapApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var yerlerTableView: UITableView!
    var yerler = [Yer]()
    var secilenYerIsmi = String()
    var secilenYerId = UUID()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        verileriAl()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ekleme))
        
        yerlerTableView.delegate = self
        yerlerTableView.dataSource = self

    }
    
    @objc func ekleme(){
        secilenYerIsmi = ""
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(verileriAl), name: NSNotification.Name("yeniYerEklendi"), object: nil)
    }
    @objc func verileriAl(){
        do{
            let liste = try context.fetch(Yer.fetchRequest())
            yerler = liste
            yerlerTableView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yerler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let yer = yerler[indexPath.row]
        cell.textLabel?.text = yer.isim
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yer = yerler[indexPath.row]
        secilenYerIsmi = yer.isim!
        secilenYerId = yer.id!
        
        performSegue(withIdentifier: "toMapsVC", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapsVC"{
            let destinationVC = segue.destination as! MapViewController
            destinationVC.secilenIsim = secilenYerIsmi
            destinationVC.secilenId = secilenYerId
        }
    }
    

}
