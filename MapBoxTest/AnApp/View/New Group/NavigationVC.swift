//
//  NavigationVC.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//


//  -------------------  DEACTIVE CODE BLOCK-------------------------------------------------
import UIKit
import Mapbox
import MapboxNavigation
import MapboxCoreNavigation
import MapboxDirections
import MapboxMaps
class NavigationVC: UIViewController {
 
    var userLocation : CLLocationCoordinate2D?
    var destinationLocation : CLLocationCoordinate2D?
    
    var mapView : NavigationMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.view.addSubview(mapView)
        if let userLocation = userLocation, let destinationLocation = destinationLocation{
            let origin = Waypoint(coordinate: userLocation)
            let destination = Waypoint(coordinate: destinationLocation)
            let routeOptions = NavigationRouteOptions(waypoints: [origin,destination])
            
            Directions.shared.calculate(routeOptions) { session, result in
                switch result{
                case.failure(let error):
                    self.errorAlert(title: K.err, message: error.localizedDescription)
                case.success(let response):
                    self.mapView.showcase(response.routes ?? [])
                    //let navigationViewController = NavigationViewController(for: response, routeIndex: 0,routeOptions: routeOptions)
                    //self.present(navigationViewController, animated: true)
                }
            }
        }
        
    }
    


}
