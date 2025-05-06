//
//  FindStationViewController.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import UIKit
import MapboxMaps
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import FirebaseAuth
import MapKit
// MapView with MapBox

class FindStationViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    // Created Needed variables
    var mapView:MapView!
    var destinationPlace : CLLocationCoordinate2D?
    var userPlace : CLLocationCoordinate2D?
    var annotationsInfo : [String:[Double]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMap()
        DispatchQueue.main.async {
            self.setLocationOnMap()
        }
        // Create an instance of UITapGestureRecognizer
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))

        // Add the gesture recognizer to the Mapbox map view
//        mapView.addGestureRecognizer(tapGestureRecognizer)


        
        
    }// end viewDidLoad
    // Permission for get user location
    func requestPermissionsButtonTapped() {
        mapView.location.requestTemporaryFullAccuracyPermissions(withPurposeKey: "CustomKey")
    }// end func
    // Implement the action method for the tap gesture recognizer
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        // Get the coordinates of the point on the map that was tapped
        let point = sender.location(in: mapView)
        let coordinate = mapView.mapboxMap.coordinate(for: point)
        // Convert the point to geographic coordinates
        print(coordinate)

        
        // Do something with the coordinates, such as add a marker or create a new map camera
    }

} // end FindStation ViewController class

// Location Permission
extension FindStationViewController: LocationPermissionsDelegate {
    func locationManager(_ locationManager: LocationManager, didChangeAccuracyAuthorization accuracyAuthorization: CLAccuracyAuthorization) {
        if accuracyAuthorization == .reducedAccuracy {
            // Perform an action in response to the new change in accuracy
            self.userPlace = locationManager.latestLocation?.coordinate
        }// end if
    }// end func
}// end extension

extension FindStationViewController{
    func setMap(){
        // Create map from MapBox with pbluic token and MapBox pre-prepared functions
        let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoiZWtpbmF0YXNveTQiLCJhIjoiY2xhdGh6OGc2MDEyajNxcW05azZzZWU2ZCJ9.l7w-hecNxz2rsxDyr0x8MA")
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 51.5290688, longitude: -0.1015986),
                                          zoom: 7,
                                          bearing: -17.6,
                                          pitch: 0)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,cameraOptions: cameraOptions,styleURI: StyleURI(rawValue:"mapbox://styles/legastive/clbetr39y000j14qnrdw8yqyn"))
        // Make frame and add to view.
        mapView = MapView(frame: mainView.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mainView.addSubview(mapView)
        
        // Show User current location on map with blue dot.
        mapView.location.delegate = self
        mapView.location.options.puckType = .puck2D()
    }// end func
    
    func setLocationOnMap(){
        Webservice().getLocations(url: URL(string:K.locationsURL)!) { locationsList in
            if let locationList = locationsList{
                // Get all locations and make annotations one by one
                for i in 0...locationList.features.count-1{
                    let place = locationList.features[i].properties
                    self.createAnnotation(place: place)
                }// end if let
            }// end for loop
        }// end if let
    }// end completion
    
    func createAnnotation(place:Properties){
        
        let placeCoordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        // Initialize a point annotation with a geometry ("coordinate" in this case)
        var pointAnnotation = PointAnnotation(coordinate: placeCoordinate)
        
        // Make the annotation show a red pin
        pointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
        pointAnnotation.iconAnchor = .bottom
        DispatchQueue.main.async {
            self.annotationsInfo.updateValue([place.latitude,place.longitude], forKey: pointAnnotation.id )
        }
        
        // Create the `PointAnnotationManager` which will be responsible for handling this annotation
        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
        pointAnnotationManager.delegate = self
        // Add the annotation to the manager in order to render it on the map.
        pointAnnotationManager.annotations = [pointAnnotation]
    }
    
    // Navigation
    func getNavigation(userLocation:CLLocationCoordinate2D,destinationLocation:CLLocationCoordinate2D){
        let origin = Waypoint(coordinate: userLocation)
        let destination = Waypoint(coordinate: destinationLocation)
        let routeOptions = NavigationRouteOptions(waypoints: [origin,destination])
        
        Directions.shared.calculate(routeOptions) { session, result in
            switch result{
            case.failure(let error):
                self.errorAlert(title: K.err, message: error.localizedDescription)
            case.success(let response):
                let navigationViewController = NavigationViewController(for: response, routeIndex: 0,routeOptions: routeOptions)
                navigationViewController.modalPresentationStyle = .fullScreen
                self.present(navigationViewController, animated: true)
                
            }
        }
    }
}// end extension

extension FindStationViewController: AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        print(annotations[0].id)
        
        DispatchQueue.main.async {
            let selectedPoint = self.annotationsInfo[annotations[0].id]
            let coordinate = CLLocationCoordinate2D(latitude: selectedPoint![0] , longitude: selectedPoint![1])
            self.userPlace = self.mapView.location.latestLocation?.coordinate
            self.destinationPlace = coordinate
            self.getNavigation(userLocation: self.userPlace!, destinationLocation: self.destinationPlace!)
        }
        
    }// end func

}// end extension

