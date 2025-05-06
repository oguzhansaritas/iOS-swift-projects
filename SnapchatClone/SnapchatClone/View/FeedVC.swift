//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Firebase
import SDWebImage
// Main View Controller - Feed VC - You can surf on this page, all-around your mates Snaps.
class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    


    @IBOutlet weak var tableView: UITableView!
    let firestoreDB = Firestore.firestore()
    
    @IBOutlet weak var tableview: UITableView!
    var snapArray = [SnapModel]() // local variable array
    
    var choosenSnap : SnapModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        getUserInfo()
        getSnapsFromFirebase()
        
        
    }
    // TableView

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as! FeedCell
        cell.feedUsernameLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC"{
            if let destinationVC = segue.destination as? SnapVC{
                destinationVC.selectedSnap = choosenSnap   // sending data to SnapDetail View Controller
            }
        }
    }

    
    func getSnapsFromFirebase(){
        
        // Taking info for feeding the FeedVC  from Firebase DB
        
        
        self.snapArray.removeAll(keepingCapacity: false) // Always starting with empty list
        firestoreDB.collection("Snaps").order(by: "date",descending: true).addSnapshotListener { snapshot, error in  // Firebase auto code
            if error != nil{ // error check
                self.errorAlert(title: "Error", message: error!.localizedDescription)
            }else{
                if snapshot?.isEmpty == false && snapshot != nil{ // controlling for received messeage empty or not
                    for document in snapshot!.documents{ // Taking documents one by one
                        let documentId = document.documentID // Document ID for deleting process
                        if let username = document.get("snapOwner") as? String{ // Taking username
                            if let imageUrlArray = document.get("imageUrlArray") as? [String]{ // Taking image URL
                                if let date = document.get("date") as? Timestamp{ // Taking date of snap
                                    
                                    // Timer for 24H difference
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(),to: Date()).hour{
                                        if difference >= 24{
                                            self.firestoreDB.collection("Snaps").document(documentId).delete()
                                        }else{ // end if
                                            let snap = SnapModel(username: username, imageUrlArray: imageUrlArray, date: date.dateValue(), timeDifference: 24-difference) // Create local variable
                                            self.snapArray.append(snap)// Add to local variable to local array
                                        }
                                    } // end if let
                                    
                                    
                                    
                                }// end of date if
                            }// end of image url array if
                        }// end of snapowner if
                        
                    }// end of for loop to taking documents one by one
                    
                }// End if
                self.tableview.reloadData()
            }// end else
        }// end of completion
        
    }// end of function
    
    func getUserInfo(){
        firestoreDB.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in // Firebase auto code
            if error != nil{ // Error controlling
                self.errorAlert(title: "Error", message: error!.localizedDescription)
            }else{
                if snapshot != nil && snapshot?.isEmpty == false{ // controlling for received messeage empty or not
                    for document in snapshot!.documents{ // Taking documents one by one
                        if let username = document.get("username") as? String{ // taking username
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email! // used Singleton to keep infos
                            UserSingleton.sharedUserInfo.username = username
                        }// end if let
                    }// end for
                }// end if
            }// end else
        }// end getting info from firebase
    }// end func
    
    // Table View Properties
    
    

}

extension FeedVC{
    func errorAlert(title:String,message:String){
               let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
               
               let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
               alert.addAction(okButton)
               self.present(alert, animated: true,completion: nil)
               
           }
}
