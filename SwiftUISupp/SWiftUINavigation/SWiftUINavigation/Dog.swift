//
//  Dog.swift
//  SWiftUINavigation
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
struct Dog:Identifiable,Hashable{
    var id = UUID()
    let name:String
}

let dogs : [Dog] = [Dog(name: "Jack"),Dog(name: "Wolf"),Dog(name: "Zorro")]
