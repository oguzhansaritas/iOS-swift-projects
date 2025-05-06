//
//  NetworkService.swift
//  SwiftUINetworkService
//
//  Created by OGUZHAN SARITAS.
//

import Foundation


protocol NetworkService{
    func download(_ resource:String) async throws -> [User]
    var type : String{get}
}
