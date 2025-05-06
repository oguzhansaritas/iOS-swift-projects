//
//  Superhero.swift
//  WidgetExample
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


struct Superhero : Codable , Identifiable{
    var id : String{image}
    
    let image : String
    let name : String
    let realName : String
    
    
    
}

let batman = Superhero(image: "batman", name: "Batman", realName: "Bruce Wayne")
let hulk = Superhero(image: "hulk", name: "Hulk", realName: "Dr.Banner")
let deadpool = Superhero(image: "deadpool", name: "Deadpool", realName: "Mr.Fanstastic")


