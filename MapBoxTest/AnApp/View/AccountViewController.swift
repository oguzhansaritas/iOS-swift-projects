//
//  AccountViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Kingfisher

// Account Detail Management Page
class AccountViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {


    // Connect Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var profilePhotoImage: UIImageView!
    //@IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var selectedCountryLabel: UILabel!
    @IBOutlet weak var pickerViewButton: UIButton!
    
    // Set variables
    var countriesList = CountriesList.sorted()
    var selectedCountry : String = ""
    let screenWidth = UIScreen.main.bounds.width-10
    let screenHeight = UIScreen.main.bounds.height/5
    var selectedRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
        selectedCountryLabel.text = selectedCountry
        makeDesignImageView()
        makeGestureRecognizerSettings()
        
        
    }//end viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameTextField.isEnabled = true
        self.usernameTextField.isEnabled = true
        self.numberTextField.isEnabled = true
    }// end willAppear
    
    @IBAction func selectCounrtyPressed(_ sender: Any) {
        makeCountryActionSheet()
    }//end button func
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        // Log Out Function
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: K.Segue.logOutSegue, sender: nil)
        } catch let signOutError {
            self.errorAlert(title: K.err, message: String(signOutError.localizedDescription))
        }// end catch

    }// end  button function
    
    @IBAction func deletePressed(_ sender: Any) {
        // Alert "r u sure?"
        errorAlert(title: "Wait!", message: "Are you sure?")
    }// end button function
    
    
    @IBAction func savePressed(_ sender: Any) {
        // Get info from textfield
        let username = usernameTextField.text
        let name = nameTextField.text
        let phone_number = numberTextField.text
        // Call the save to db function
        saveDataToDatabase(name: name ?? "", username: username ?? "", phone_number: phone_number ?? "",country:selectedCountryLabel.text ?? "")
    }//end button function
    
    
    
    // MARK: - PickerView
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 5))
        label.text = countriesList[row]
        label.sizeToFit()
        return label
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesList.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countriesList[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesList[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }

}

// MARK: - Image Picker Controller
extension AccountViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func makeDesignImageView(){
        //profilePhotoImage.image = UIImage(systemName: "person.circle")
        profilePhotoImage.layer.cornerRadius = 25
        profilePhotoImage.sizeToFit()
    }// end func
    
    func makeGestureRecognizerSettings(){
        profilePhotoImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        profilePhotoImage.addGestureRecognizer(gestureRecognizer)
        
        selectedCountryLabel.isUserInteractionEnabled = true
        let gestRecognizer = UITapGestureRecognizer(target: self, action: #selector(makeCountryActionSheet))
        selectedCountryLabel.addGestureRecognizer(gestRecognizer)
    }// end func
    
    // Settings for choose the image
    @objc func choosePicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker,animated: true)
        
    }// end func
    
    //Image picker controller settings
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profilePhotoImage.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
        
    }// end func
}

// MARK: - Extra Functions
extension AccountViewController{
    
    @objc func makeCountryActionSheet(){
        
        // Custom Action sheet with code
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        // alert properties
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        // set alert title & message
        let alert = UIAlertController(title: "Select a Country", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = pickerViewButton
        alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
        alert.setValue(vc, forKey: "contentViewController")
        // set alert actions
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: { alert in
            self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Select", style: .default,handler: { alert in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            self.selectedCountry = self.countriesList[self.selectedRow]
            self.selectedCountryLabel.text = self.selectedCountry
        }))
        // present
        self.present(alert, animated: true)
    }
    
    // Get user Info to fill information areas
    func getUserInfo(){
        // call the database
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.email
        
        // Find the account owners field
        db.collection("userInfo").whereField("user_Mail", isEqualTo: currentUser!).getDocuments { snapshot, error in
            if error != nil{
                // Check Error
                print("Error.")
            }else{
                // Take User Info and Paste textfields
                for document in snapshot!.documents{
                    let name = document.get("name")
                    let username = document.get("username")
                    let phone = document.get("phone_number")
                    let country = document.get("country")
                    let imageUrl = document.get("imageURL")
                    self.nameTextField.text = name as? String
                    self.usernameTextField.text = username as? String
                    self.numberTextField.text = phone as? String
                    self.selectedCountryLabel.text = country as? String
                    if let imageUrl = imageUrl as? String{
                        self.profilePhotoImage.kf.setImage(with: URL(string: (imageUrl)))
                    }else{
                        self.profilePhotoImage.image = UIImage(systemName: "person.circle")
                    }// end else
                }//end for
            }//end else
        }// end closure
        
    }// end func
    
    //
    func saveDataToDatabase(name:String,username:String,phone_number:String,country:String){
        // Usefull Firabase abbreviations
        let db = Firestore.firestore()
        let storage = Storage.storage()
        var imageUrl = ""
        
        // Setting up Firebase Storage
        let storageReference = storage.reference()
        // Creating FirebaseStorage folder
        let mediaFolder = storageReference.child("profilePhotos")
        // trying to convert image to data
        if let imageData = profilePhotoImage.image?.jpegData(compressionQuality: 0.5){
            let uniqueID = UUID().uuidString
            // saving with unique id
            let imageReference = mediaFolder.child("\(uniqueID).jpeg")
            imageReference.putData(imageData, metadata: nil) { metadata, error in
                if error != nil{
                    self.errorAlert(title: K.err, message: error!.localizedDescription)
                }else{
                    imageReference.downloadURL { URL, error in
                        if error == nil{
                            // image url from media folder
                            imageUrl = URL?.absoluteString ?? K.notFoundImageUrl
                            // We saved our image data to Firebase Storage and took the URL of Image then we can save URL to Account Owner Infos where we keep all information about him.
                            
                            // call the database
                            let currentUser = Auth.auth().currentUser?.email

                            // Find the account owners field
                            db.collection("userInfo").whereField("user_Mail", isEqualTo: currentUser!).getDocuments { snapshot, error in
                                if error != nil{
                                    // Check Error
                                    print("Error.")
                                }else{
                                    // Get document from snapshot
                                    for document in snapshot!.documents{
                                        let documentID = document.documentID
                                        // Add new data about user to database
                                        if document.get("user_Mail") is String{
                                            var userInfos = [String:Any]()
                                            userInfos.updateValue(name ,forKey: "name")
                                            userInfos.updateValue(username , forKey: "username")
                                            userInfos.updateValue(phone_number , forKey: "phone_number")
                                            userInfos.updateValue(country ,forKey: "country")
                                            userInfos.updateValue(imageUrl, forKey: "imageURL")
                                            
                                            // merge with previous info
                                            db.collection("userInfo").document(documentID).setData(userInfos,merge: true) { error in
                                                if error == nil{
                                                    self.errorAlert(title: "Great!", message: "We saved your Info.")
                                                    self.nameTextField.isEnabled = false
                                                    self.usernameTextField.isEnabled = false
                                                    self.numberTextField.isEnabled = false
                                                }// end if
                                            }//end closure
                                        }//end if
                                    }// end for
                                }// end else
                            }//end closure
                        }else{
                            self.errorAlert(title: K.err, message: error!.localizedDescription)
                        }// end if
                    }// end closure
                }// end else
            }// end closure
        }// end if let
    }// end func
}// end extension
