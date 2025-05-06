//
//  FindStationViewController.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//



// NEEDS TO BE REFACTORING SUCH A MESSY CODE!



import UIKit
import Mapbox
import MapboxNavigation
import MapboxCoreNavigation
import MapboxDirections
import MapboxMaps
import ClusterKit
// Find View Controller with MapBox
class FindStationViewController: UIViewController{
    
    @IBOutlet weak var MainView: UIView!
    internal var mapView: MapView!
    var placeCoordinate = [String:[Double]]()
    var locationListViewModel : LocationListViewModel?
    var userPlace = CLLocationCoordinate2D()
    var destPlace = CLLocationCoordinate2D()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        makeMapView()
        
        getLocations()
        mapView.location.options.puckType = .puck2D()
        /*
         let centerCoordinate = mapView.location.latestLocation
         let coordinate = CLLocationCoordinate2D(latitude: (centerCoordinate?.coordinate.latitude)!, longitude: (centerCoordinate?.coordinate.longitude)!)
         let options = MapInitOptions(cameraOptions: CameraOptions(center: coordinate, zoom: 8.0))
         */
        let place = CLLocationCoordinate2D(latitude: 51.5290688, longitude: -0.1015986)
        userPlace = place
        let dest = CLLocationCoordinate2D(latitude: 51.530688, longitude: -0.145986)
        destPlace = dest
        mapView.gestures.options.pitchEnabled = true
        
        //


        
        
    }//end viewDidLoad
    
    
    
    func getLocations(){
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
    }// end function
    
}// end class

// MARK: - MapView

extension FindStationViewController: LocationPermissionsDelegate,AnnotationInteractionDelegate  {
    
    func makeMapView(){
        
        // Create MapBox Map View with code
        // See MapBox Documentation
        let myResourceOptions = ResourceOptions(accessToken: K.MapBox_ACCESS_KEY_TOKEN)
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 51.5290688, longitude: -0.1015986),
                                                  zoom: 7,
                                                  bearing: -17.6,
                                                  pitch: 0)
        // Pass camera options to map init options
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,cameraOptions: cameraOptions)
        mapView = MapView(frame: MainView.bounds, mapInitOptions: myMapInitOptions)
        //mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.MainView.addSubview(mapView)
        mapView.location.delegate = self
        
    }// end func
    
    
    func requestPermissionsButtonTapped() {
        mapView.location.requestTemporaryFullAccuracyPermissions(withPurposeKey: "CustomKey")
    }
    
    
    func locationManager(_ locationManager: LocationManager, didChangeAccuracyAuthorization accuracyAuthorization: CLAccuracyAuthorization) {
        if accuracyAuthorization == .reducedAccuracy {
            // Perform an action in response to the new change in accuracy
            
        }//end if
    }// end function
    
    
    
    // MARK: -Annotations and Interactive
    func makeAnnotation(place: Properties){
        // Creating custom annotations with our data
        var coordinate =  CLLocationCoordinate2D()
        coordinate.latitude = place.latitude
        coordinate.longitude = place.longitude
        var pointAnnotation = PointAnnotation(coordinate: coordinate)
        
        // Make the annotation show a red pin
        pointAnnotation.point.coordinates = coordinate
        pointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: place.title)
        pointAnnotation.iconAnchor = .bottom
        
        // Add View
        DispatchQueue.main.async {
            self.addViewAnnotation(at: coordinate,title: place.title)
        }
        
        
        placeCoordinate.updateValue([place.latitude,place.longitude], forKey: pointAnnotation.id)
        // Create the `PointAnnotationManager` which will be responsible for handling this annotation
        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
        pointAnnotationManager.delegate = self
        // Add the annotation to the manager in order to render it on the map.
        pointAnnotationManager.annotations = [pointAnnotation]
        
    }// end func
    
    // MARK: Annotation Pressed
    public func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        
        let coordinate = placeCoordinate[annotations[0].id]
        destPlace.latitude = coordinate![0]
        destPlace.longitude = coordinate![1]
        getNavigation(userLocation: userPlace, destinationLocation: destPlace)
        
        
        
        
    }
    
    // MARK: Create a View to Annotation
    func createSampleView(withText text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }
   
    private func addViewAnnotation(at coordinate: CLLocationCoordinate2D, title:String) {
        let options = ViewAnnotationOptions(
            geometry: Point(coordinate),
            width: 100,
            height: 40,
            allowOverlap: false,
            anchor: .top
            
        )
        let sampleView = createSampleView(withText: title)
        try? self.mapView.viewAnnotations.add(sampleView, options: options)
    }
    
    
    
    
    // MARK: Navigation
    
    
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
    
    // MARK: ClusterKit
    

    
}
