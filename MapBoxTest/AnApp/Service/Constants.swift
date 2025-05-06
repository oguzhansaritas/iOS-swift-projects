//
//  Constants.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

struct K {
    static let welcomeMessage = ["Welcome","Wilkommen","Hoş Geldiniz","Hola","Bienvenido","Konnichiwa","Salut","Privet"]
    static let newsURL = "https://raw.githubusercontent.com/observer23/newsApi/main/api" // static
    //"https://newsapi.org/v2/top-headlines?q=tesla&apiKey=d1004b7a35e149a5a50d0e7065210052" //dynamic
    static let notFoundImageUrl = "https://www.webtekno.com/images/editor/default/0003/49/d69c8ccfa20fc2ef66b4655df8631cd433a037a3.jpeg"
    
    static let locationsURL = "https://raw.githubusercontent.com/observer23/newsApi/main/UK.geojson" //static
    
    static let reusableCell = "Cell"
    static let d = "d"
    struct Segue{
        static let loginSegue = "LoginToFeed"
        static let registerSegue = "RegisterToFeed"
        static let logOutSegue = "LogOutToWelcome"
        static let resetPaswordSegue = "LoginToReset"
        static let newsDetailSegue = "toNewsDetail"
        static let toRoutesSegue = "toShowRoutes"
    }
    
    
    static let MapBox_ACCESS_KEY_TOKEN = "pk.eyJ1IjoiZWtpbmF0YXNveTQiLCJhIjoiY2xhdGh6OGc2MDEyajNxcW05azZzZWU2ZCJ9.l7w-hecNxz2rsxDyr0x8MA"
    
    
    static let err = "Error"
    static let errPasswordMessage = "Please check your password."
    static let errLoginMessage = "Please check your Mail or Password."

}
