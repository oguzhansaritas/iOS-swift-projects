//
//  DetailVC.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import MapKit
import Firebase
import SDWebImage
class DetailVC: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeCommentText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var choosenId = String()
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        placeImageView.layer.cornerRadius = 25
        getDetail()
        mapView.delegate = self
        
    }
    
    func getDetail(){
        let  firestoredb = Firestore.firestore()
        let docRef = firestoredb.collection("Places").document(choosenId)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let placeData = document.data(){
                    //print("Document data: \(dataDescription)")
                    self.placeNameText.text = placeData["place_name"]! as? String
                    self.placeTypeText.text = placeData["place_type"]! as? String
                    self.placeCommentText.text = placeData["place_comment"]! as? String
                    if let placeLatitude = placeData["latitude"] as? String{
                        if let placeLaDouble = Double(placeLatitude){
                            self.choosenLatitude = placeLaDouble
                        }
                    }
                    if let placeLongitude = placeData["longitude"] as? String{
                        if let placeLoDouble = Double(placeLongitude){
                            self.choosenLongitude = placeLoDouble
                        }
                    }
                    if let imageData = placeData["image_url"] as? String{
                        self.placeImageView.sd_setImage(with: URL(string: imageData))
                    }
                    
                }
                // Map
                
                let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                let region = MKCoordinateRegion(center: location, span: span)
                self.mapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.placeNameText.text!
                annotation.subtitle = self.placeCommentText.text!
                self.mapView.addAnnotation(annotation)
                
            } else {
                print("Document does not exist")
            }
            
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        var reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        
        if pinView == nil{
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLongitude != 0.0 && self.choosenLatitude != 0.0{
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks{
                    if placemark.count > 0 {
                        
                        let mkplacemark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkplacemark)
                        mapItem.name = self.placeNameText.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
}
