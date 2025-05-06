//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import Firebase
class UploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    let storage = Storage.storage()// Firebase Storage
    let firestoreDB = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    @objc func choosePicture(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker,animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        // Storage
        
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")// Creating firebase folder
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5){ // trying to change image to data
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpeg") // saving with unique id
            
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    self.errorAlert(title: "Error", message: error!.localizedDescription)
                }else{
                    imageReference.downloadURL { URL, error in
                        if error == nil{
                            let imageUrl = URL?.absoluteString // image url from media folder
                            // Firestore
                            
                            
                            // Checking firestore for previous Snaps  if does exists.
                            self.firestoreDB.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { snapshot, error in
                                if error != nil{
                                    self.errorAlert(title: "Error", message: error!.localizedDescription)
                                }else{
                                    if snapshot?.isEmpty == false && snapshot != nil{
                                        for document in snapshot!.documents{
                                            let documentId = document.documentID
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String]{
                                                // Taking info from Firebase to local
                                                
                                                imageUrlArray.append(imageUrl!)
                                                
                                                
                                                
                                                let additionalDictionary = ["imageUrlArray":imageUrlArray] as [String:Any]
                                                
                                                self.firestoreDB.collection("Snaps").document(documentId).setData(additionalDictionary, merge: true) { error in
                                                    if error == nil{
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(systemName: "folder")
                                                        
                                                    } // end if
                                                }// end completion
                                            }// end if
                                        }// end for
                                        
                                    } // end if
                                    
                                    // if previous Snap doesnt exist then add as new Snap owner
                                    else{
                                        let snapDictionary = ["imageUrlArray" : [imageUrl!],"snapOwner":UserSingleton.sharedUserInfo.username,"date":FieldValue.serverTimestamp()] as [String:Any]
                                        // Dictionary to send database
                                        
                                        self.firestoreDB.collection("Snaps").addDocument(data: snapDictionary) { error in
                                            // creating firebase collection with owner, image url and time stamp
                                            if error != nil{
                                                self.errorAlert(title: "Error", message: error!.localizedDescription)
                                            }else{
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImageView.image = UIImage(systemName: "folder")
                                            }// end else
                                        }// end completion
                                        
                                    }// end else
                                }
                            } // end else
                            
                        }// end completion
                    }// end if
                }// end else
            }// end completion
        }// end completion
    }// end button function
    
}// end of View Controller

// Extension for Extra functions
extension UploadVC{
    func errorAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
        
    }
}
