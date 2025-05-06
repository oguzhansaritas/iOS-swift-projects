//
//  Webservice.swift
//  SwiftUINetworkService
//
//  Created by OGUZHAN SARITAS.
//

import Foundation

enum NetworkError: Error{
    case invalidUrl
    case invalidServerResponse
}
class WebService:NetworkService{
    var type: String = "WebService"
    
    func download(_ resource:String) async throws -> [User]{
        guard let url = URL(string: resource)else{
            throw NetworkError.invalidUrl
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                throw NetworkError.invalidServerResponse
        }
        return try JSONDecoder().decode([User].self, from: data)
        
        
        
        
        
    }// end function
}// end class
