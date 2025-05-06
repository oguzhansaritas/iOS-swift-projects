//
//  Cat.swift
//  SWiftUINavigation
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

struct Cat:Identifiable,Hashable{
    var id = UUID()
    let name:String
}

let cats : [Cat] = [Cat(name: "Ayaz"),Cat(name: "Pıtır"),Cat(name: "Çıtır")]
