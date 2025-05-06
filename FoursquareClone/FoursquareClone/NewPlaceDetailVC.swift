//
//  NewPlaceDetailVC.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class NewPlaceDetailVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeNameText: UITextField!
    
    @IBOutlet weak var placeTypeText: UITextField!
    
    @IBOutlet weak var placeCommentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
    @IBAction func toMapButton(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeCommentText.text != ""{
            let placeModel = PlaceModel.sharedInstance
            placeModel.placeName = placeNameText.text!
            placeModel.placeType = placeTypeText.text!
            placeModel.placeComment = placeCommentText.text!
            if let image = placeImageView.image{
                placeModel.placeImage = image
                performSegue(withIdentifier: "toMapVC", sender: nil)
            }
            
            
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Cant be Empty.", preferredStyle: .alert)
            let okbutton = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okbutton)
            self.present(alert,animated: true)
        }
        
    }
    
    

}
