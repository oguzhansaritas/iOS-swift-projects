//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Firebase
class PlacesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var placeArray = [Place]()
    var selectedPlaceId = String()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logOutButtonClicked))
        navigationController?.navigationBar.topItem?.title = "Welcome"
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            let destinationVC = segue.destination as! DetailVC
            destinationVC.choosenId = selectedPlaceId
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeArray[indexPath.row].place_id
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeArray[indexPath.row].place_name
        return cell
    }
    
    
    


}
extension PlacesVC{
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toNewPlaceVC", sender: nil)
    }
    @objc func logOutButtonClicked(){
        do{
                    try Auth.auth().signOut()
                    performSegue(withIdentifier: "toLandPageVC", sender: nil)
                }catch{
                    print(error.localizedDescription)
                }
    }
    
    func getDataFromFirebase(){
        let  firestoredb = Firestore.firestore()
                firestoredb.collection("Places").addSnapshotListener{
                    snapshot,error in
                    if error != nil{
                        print(error?.localizedDescription ?? "Error")
                        
                    }else{
                        if snapshot?.isEmpty != true  && snapshot != nil {
                            self.placeArray.removeAll()
                            
                            for document in  snapshot!.documents {
                                let documentId = document.documentID
                                print(documentId)
                                if let latitude = document.get("latitude") as? String{
                                    if let longitude = document.get("longitude") as? String{
                                        if let place_name = document.get("place_name") as? String{
                                                if let place_type = document.get("place_type") as? String{
                                                    if let place_comment = document.get("place_comment") as? String{
                                                        let place = Place(latitude: latitude, longitude: longitude, place_name: place_name, place_type: place_type, place_comment: place_comment,place_id: documentId)
                                                        print("data geldi")
                                                        self.placeArray.append(place)
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            
                            self.tableView.reloadData()
                        }
                        
                    }
                }
    }
}
