//
//  FavouriteModel.swift
//  BookShelfSwiftUI
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


struct FavouriteModel:Identifiable{
    var id = UUID()
    var title : String
    var elements : [FavouriteElements]
    
    
}

struct FavouriteElements:Identifiable{
    var id = UUID()
    var name:String
    var imagename:String
    var description:String
    
}

let pinhani = FavouriteElements(name: "Pinhani", imagename: "pinhani", description: "Güzel")
let teoman = FavouriteElements(name: "Teoman", imagename: "teoman", description: "Güzel")
let gazapizm = FavouriteElements(name: "Gazapizm", imagename: "gazapizm", description: "Güzel")

let favouriteBands = FavouriteModel(title: "Music", elements: [pinhani,teoman,gazapizm])


let avengers = FavouriteElements(name: "Avengers", imagename: "avengers", description: "Güzel")
let whiplash = FavouriteElements(name: "Whiplash", imagename: "whiplash", description: "Güzel")
let joker = FavouriteElements(name: "Joker", imagename: "joker", description: "Güzel")

let favouriteMovies = FavouriteModel(title: "Movie", elements: [avengers,whiplash,joker])

let myFavourites = [favouriteBands,favouriteMovies]
