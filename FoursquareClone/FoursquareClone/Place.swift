//
//  Place.swift
//  FoursquareClone
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


class Place{
    var latitude : String
    var longitude : String
    var place_name : String
    var place_type : String
    var place_comment : String
    var place_id:String
    
    
    init(latitude: String, longitude: String, place_name: String, place_type: String, place_comment: String,place_id:String) {
        self.latitude = latitude
        self.longitude = longitude
        self.place_name = place_name
        self.place_type = place_type
        self.place_comment = place_comment
        self.place_id = place_id
    }
    
    
}
