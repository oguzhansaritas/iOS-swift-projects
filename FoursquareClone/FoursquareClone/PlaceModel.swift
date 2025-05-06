//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
import UIKit
class PlaceModel{
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var latitude = ""
    var longitude = ""
    
    private init (){}
    
}
