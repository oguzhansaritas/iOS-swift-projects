//
//  ViewController.swift
//  MapApp
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import MapKit
import CoreData


class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var yerAdıTextField: UITextField!
    @IBOutlet weak var notTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var kaydetButtonView: UIButton!
    var locationManager = CLLocationManager()
    var secilenKoordinat = CLLocationCoordinate2D()
    
    var secilenIsim = String()
    var secilenId = UUID()
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongtitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(konumSec(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if secilenIsim != "" {
            let uuidString = secilenId.uuidString
            do{
                let fr = Yer.fetchRequest()
                fr.predicate = NSPredicate(format: "id = %@", uuidString)
                let istenenYer = try context.fetch(fr)
                annotationTitle = istenenYer[0].isim!
                annotationSubtitle = istenenYer[0].not!
                annotationLatitude = istenenYer[0].latitude
                annotationLongtitude = istenenYer[0].longtitude
                let annotation = MKPointAnnotation()
                annotation.title = annotationTitle
                annotation.subtitle = annotationSubtitle
                let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongtitude)
                annotation.coordinate = coordinate
                mapView.addAnnotation(annotation)
                locationManager.stopUpdatingLocation()
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: coordinate, span:span)
                mapView.setRegion(region, animated: true)
                yerAdıTextField.text = annotationTitle
                notTextField.text = annotationSubtitle
                kaydetButtonView.isEnabled = false
                
            }catch{
                print(error.localizedDescription)
            }
        }else{
            
        }
        
    }
    
    @objc func konumSec(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let dokunulanNokta = gestureRecognizer.location(in: mapView)
            let dokunulanKoordinat = mapView.convert(dokunulanNokta, toCoordinateFrom: mapView)
            
            secilenKoordinat = dokunulanKoordinat
            let annotation = MKPointAnnotation()
            annotation.coordinate = dokunulanKoordinat
            annotation.title = yerAdıTextField.text
            annotation.subtitle = notTextField.text
            
            mapView.addAnnotation(annotation)
            
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseId = "MyAnnotation"
        var pinview = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinview == nil{
            pinview = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinview?.canShowCallout = true
            pinview?.tintColor = .red
            
            let button = UIButton(type: .detailDisclosure)
            pinview?.rightCalloutAccessoryView = button
            
        }else{
            pinview?.annotation = annotation
        }
        return pinview
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if secilenIsim != ""{
            var requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongtitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation){ (placemarkDizisi,hata) in
                if let placemarks = placemarkDizisi{
                    if placemarks.count>0{
                        
                        let yeniPlacemark = MKPlacemark(placemark: placemarks[0])
                        let item = MKMapItem(placemark: yeniPlacemark)
                        
                        item.name = self.annotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
               
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations[0].coordinate.latitude)
        //print(locations[0].coordinate.longitude)
        if secilenIsim == ""{
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location, span:span)
            mapView.setRegion(region, animated: true)
        }
        
        
    }
    
    
    @IBAction func kaydetButtonTıklandı(_ sender: Any) {
        let yeniYer = Yer(context: context)
        yeniYer.isim = yerAdıTextField.text
        yeniYer.latitude = secilenKoordinat.latitude
        yeniYer.longtitude = secilenKoordinat.longitude
        yeniYer.not = notTextField.text
        yeniYer.id = UUID()
        
        app.saveContext()
        
        NotificationCenter.default.post(name: NSNotification.Name("yeniYerEklendi"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    

}

