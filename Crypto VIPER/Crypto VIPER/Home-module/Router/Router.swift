//
//  Router.swift
//  Crypto VIPER
//
//  Created by OGUZHAN SARITAS.
//

import Foundation
import UIKit
// Interacts with Presenter
// Coordination Center
// Entry point must be declare

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    var entry : EntryPoint?{get}
    static func startExecution()-> AnyRouter // static for be reachble from anywhere
}

class CryptoRouter:AnyRouter{
    var entry: EntryPoint?
    
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
}

