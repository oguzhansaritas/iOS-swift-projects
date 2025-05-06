//
//  LoginCheckTests.swift
//  LoginCheckTests
//
//  Created by OGUZHAN SARITAS.
//

import XCTest
@testable import LoginCheck

final class LoginCheckTests: XCTestCase {
    
    private var viewModel : RootViewModel!
    private var loginstorageservice :MockLoginStorageService!
    private var output : MockRootViewModelOutput!

    override func setUpWithError() throws {
        loginstorageservice = MockLoginStorageService()
        output = MockRootViewModelOutput()
        viewModel = RootViewModel(loginStorageService: loginstorageservice)
        viewModel.output = output
        
    }

    override func tearDownWithError() throws {
        viewModel = nil
        loginstorageservice = nil
    }

    func testShowLogin_whenLoginStorageReturnsEmptyUserAccessToken() throws {
        loginstorageservice.storage = [:]
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }
    func testShowLogin_whenLoginStorageReturnsEmptyString() throws {
        loginstorageservice.storage["ACCESS_TOKEN"] = ""
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }
    func testShowLogin_whenLoginStorageReturnsUserAccessToken() throws {
        loginstorageservice.storage["ACCESS_TOKEN"] = "szexdfcgvhbjnkml"
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .mainApp)
    }
}


class MockLoginStorageService : LoginStorageServiceProtocol{
    var userAccessTokenKey: String{
        return "ACCESS_TOKEN"
    }
    var storage : [String:String] = [:]
    func setUserAccessToken(token: String) {
        storage[userAccessTokenKey] = token
    }
    
    func getUserAccessToken() -> String? {
        return storage[userAccessTokenKey]
    }
}

class MockRootViewModelOutput : RootViewModelProtocol{
    enum Check{
        case login
        case mainApp
    }
    var checkArray : [Check] = []
    func showMainApp() {
        checkArray.append(.mainApp)
    }
    
    func showLogin() {
        checkArray.append(.login)
    }
    
    
}
