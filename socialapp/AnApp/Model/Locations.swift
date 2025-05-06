//
//  Locations.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

//https://raw.githubusercontent.com/observer23/newsApi/main/UK.geojson
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chargingPoints = try? newJSONDecoder().decode(ChargingPoints.self, from: jsonData)


// MARK: - ChargingPoints
class ChargingPoints: Codable {
    let type: String
    let features: [Feature]

    init(type: String, features: [Feature]) {
        self.type = type
        self.features = features
    }
}

// MARK: - Feature
class Feature: Codable {
    let id: ID
    let type: FeatureType
    let properties: Properties
    let geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type, properties, geometry
    }

    init(id: ID, type: FeatureType, properties: Properties, geometry: Geometry) {
        self.id = id
        self.type = type
        self.properties = properties
        self.geometry = geometry
    }
}

// MARK: - Geometry
class Geometry: Codable {
    let coordinates: [Double]
    let type: GeometryType

    init(coordinates: [Double], type: GeometryType) {
        self.coordinates = coordinates
        self.type = type
    }
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - ID
class ID: Codable {
    let oid: String

    enum CodingKeys: String, CodingKey {
        case oid = "$oid"
    }

    init(oid: String) {
        self.oid = oid
    }
}

// MARK: - Properties
class Properties: Codable {
    let levelObj: [Level]?
    let typeObj: [String]?
    let whatIsNearbyObj: [Status]?
    let uniqueID, title: String
    let availability: Availability
    let level: Level
    let type: String
    let address: String?
    let longitude, latitude: Double
    let country: Country
    let usageCost: String?
    let whatIsNearby: Status
    let propertiesOperator: String?
    let numberOfStationsBays: Int?
    let status: Status

    enum CodingKeys: String, CodingKey {
        case levelObj = "level_obj"
        case typeObj = "type_obj"
        case whatIsNearbyObj = "what_is_nearby_obj"
        case uniqueID = "unique_id"
        case title, availability, level, type, address, longitude, latitude, country
        case usageCost = "usage_cost"
        case whatIsNearby = "what_is_nearby"
        case propertiesOperator = "operator"
        case numberOfStationsBays = "number_of_stations_bays"
        case status
    }

    init(levelObj: [Level]?, typeObj: [String]?, whatIsNearbyObj: [Status]?, uniqueID: String, title: String, availability: Availability, level: Level, type: String, address: String?, longitude: Double, latitude: Double, country: Country, usageCost: String?, whatIsNearby: Status, propertiesOperator: String?, numberOfStationsBays: Int?, status: Status) {
        self.levelObj = levelObj
        self.typeObj = typeObj
        self.whatIsNearbyObj = whatIsNearbyObj
        self.uniqueID = uniqueID
        self.title = title
        self.availability = availability
        self.level = level
        self.type = type
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
        self.country = country
        self.usageCost = usageCost
        self.whatIsNearby = whatIsNearby
        self.propertiesOperator = propertiesOperator
        self.numberOfStationsBays = numberOfStationsBays
        self.status = status
    }
}

enum Availability: String, Codable {
    case availabilityPublic = "Public"
    case privateForStaffVisitorsOrCustomers = "Private - For Staff, Visitors or Customers"
    case publicMembershipRequired = "Public - Membership Required"
    case publicPayAtLocation = "Public - Pay At Location"
}

enum Country: String, Codable {
    case unitedKingdom = "United Kingdom"
}

enum Level: String, Codable {
    case empty = ""
    case level2MediumOver2KW = "Level 2 : Medium (Over 2kW)"
    case level2MediumOver2KWLevel3HighOver40KW = "Level 2 : Medium (Over 2kW),Level 3:  High (Over 40kW)"
    case level3HighOver40KW = "Level 3:  High (Over 40kW)"
    case level3HighOver40KWLevel2MediumOver2KW = "Level 3:  High (Over 40kW),Level 2 : Medium (Over 2kW)"
}

enum Status: String, Codable {
    case operational = "Operational"
    case plannedForFutureDate = "Planned For Future Date"
    case unknown = "Unknown"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}
