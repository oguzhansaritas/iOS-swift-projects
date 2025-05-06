//
//  FindViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//


//  -------------------  DEACTIVE CODE BLOCK-------------------------------------------------
//  -------------------  For AppleMaps-------------------------------------------------
import UIKit
import MapKit

class FindViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationListViewModel : LocationListViewModel?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationsWithAnnotations()
        mapView.delegate = self
        
        // Get user location
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    // MARK: - MapView
    
    // User location did update func and get the user last location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Getting user current location
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span:span)
        mapView.setRegion(region, animated: true)
    }
    
    
    // Create reuseable Annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // MapView show all annotations.
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
            //annotationView?.image = UIImage(named: "flash")
            
        } else {
            annotationView!.annotation = annotation
            
        }// end else
        
        
        return annotationView
    }// end function
    
    
    // App to Maps for navigation
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Create wanted location coordinate parameters
        let requestLocation = CLLocation(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
        // Call CLGeocoder to make request to Maps
        CLGeocoder().reverseGeocodeLocation(requestLocation){ (placemarks,error) in
            if let placemark = placemarks{
                if placemark.count>0{
                    let newPlacemark = MKPlacemark(placemark: placemark[0])
                    let item = MKMapItem(placemark: newPlacemark)
                    // Opening Setting when Maps load
                    item.name = view.annotation?.title ?? "Place"
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                }// end if
            }// end if let
        }//end closure
    }//end func
    
}// end class


extension FindViewController{
    
    func getLocationsWithAnnotations(){
        // Calling webservice which is static JSON for CharginPoints Locations after that it crates Annotations from theri coordinates and Titles'.
        
        WebService().getLocations(url: URL(string: K.locationsURL)!) { locations in
            if let locations = locations{
                // data transfer to this VC
                self.locationListViewModel = LocationListViewModel(locationList: locations)
                let locationsList = self.locationListViewModel?.locationList
                // Get all locations and make annotations one by one
                for i in 0...locationsList!.features.count-1{
                    if let place = locationsList?.features[i].properties{
                        self.makeAnnotation(place: place)
                    }// end if let
                }// end for
            }// end if
        }// end closure
        
    }// end func
    
    
    func makeAnnotation(place:Properties){
        //Custom Annotation Function
        let addAnotation = MKPointAnnotation()
        addAnotation.title = place.title
        addAnotation.subtitle = place.type
        addAnotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        // Adding to MapView
        self.mapView.addAnnotation(addAnotation)
    }// end func
}// end extension
