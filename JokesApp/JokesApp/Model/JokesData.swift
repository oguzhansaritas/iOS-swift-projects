//
//  JokesData.swift
//  JokesApp
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

struct Response: Identifiable,Codable {
    let id = UUID()
    let type: String
    let value: [Value]

}
struct Value: Identifiable,Codable {
    let id: Int
    let joke: String
    //let categories: [Any]

}


