//
//  WebService.swift
//  AnApp
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
// Api source https://newsapi.org/docs/endpoints/top-headlines
// Api key : d1004b7a35e149a5a50d0e7065210052

//Web service for getting data from APIs.

class WebService{
    // For news
    func getNews(url:URL,completion: @escaping ((News?)->())){
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Calling URL Session with URL
            if let error = error{
                // if error exist
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                // if data is safe we can decode
                do{
                    let newsList = try? JSONDecoder().decode(News.self, from: data)
                    if let newsList = newsList{
                        completion(newsList)
                    }
                }
                
            }
        }.resume()
    }
    // For Charging Points
    func getLocations(url:URL,completion: @escaping ((ChargingPoints?)->())){
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Calling URL Session with URL
            if let error = error{
                // if error exist
                print("Error.")
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                // if data is safe we can decode
                do{
                    let locationList = try? JSONDecoder().decode(ChargingPoints.self, from: data)
                    if let locationList = locationList{
                        completion(locationList)
                    }
                }
                
            }
        }.resume()
    }
    
}
