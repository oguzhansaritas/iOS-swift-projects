//
//  MapVC.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import MapKit
import Firebase
class MapVC: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    //var choosenLatitude = String()
    //var choosenLongitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(PlaceModel.sharedInstance.placeName)
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    @objc func chooseLocation(gestureRecognizer:UITapGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.latitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.longitude = String(coordinates.longitude)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let placesmodel = PlaceModel.sharedInstance
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let placesFolder = storageReference.child("Places")
        
        if let data = PlaceModel.sharedInstance.placeImage.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReference = placesFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil{
                    self.errorAlert(title: "Errort", message: error?.localizedDescription ?? "Hata.")
                    
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl{
                                let firestorePlace = [
                                    "place_name":placesmodel.placeName,
                                                      "place_type":placesmodel.placeType,
                                                      "place_comment":placesmodel.placeComment,
                                                      "latitude":placesmodel.latitude,
                                                    "image_url":imageUrl,
                                                      "longitude":placesmodel.longitude] as! [String:Any]
                                
                                
                                let firestoreDB = Firestore.firestore()
                                
                                
                                firestoreDB.collection("Places").addDocument(data:firestorePlace) { error in
                                    if error != nil{
                                        self.errorAlert(title: "Hataa", message: error?.localizedDescription ?? "Hata")
                                    }else{
                                        self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension MapVC{
    func errorAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
        
    }
}
