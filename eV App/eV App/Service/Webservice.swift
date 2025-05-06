//
//  Webservice.swift
//  eV App
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

class Webservice{
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
                    }// end if
                }// end do
                
            }// end data
        }.resume()
    }// end completion
}// end class
