//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by OGUZHAN SARITAS.
//

import XCTest
@testable import ProtocolOrientedUIKit

final class ProtocolOrientedUIKitTests: XCTestCase {

    private var sut : UserViewModel!
    private var userService : MockUserService!
    private var output : MockUserViewModelOutput!
    override func setUpWithError() throws {

        userService = MockUserService()
        output = MockUserViewModelOutput()
        sut = UserViewModel(userService: userService)
        sut.output = output
    }

    override func tearDownWithError() throws {
        userService = nil
        sut = nil
    }

    func testUpdateView_whenAPISuccess_showsNameEmailUsername() throws {
       let mockUser = User(id: 1, name: "Joe", username: "joeo", email: "joe@icloud.com", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
        userService.fetchUserMockResult = .success(mockUser)
        sut.getUsers()
        XCTAssertEqual(output.updateViewArray.first?.username, "joeo")
    }
    func testUpdateView_whenAPIFaiulre_showsNoUserText() throws {
        
        userService.fetchUserMockResult = .failure(NSError())
         sut.getUsers()
         XCTAssertEqual(output.updateViewArray.first?.name, "No User")
    }


}
class MockUserService:UserService{
    var fetchUserMockResult : Result<ProtocolOrientedUIKit.User, Error>?
    func fetchUser(completion: @escaping (Result<ProtocolOrientedUIKit.User, Error>) -> Void) {
        if let result = fetchUserMockResult{
            completion(result)
        }
    }
}
class MockUserViewModelOutput : UserViewModelProtocol{
    var updateViewArray : [(name:String,username:String,email:String)] = []
    func updateView(name: String, username: String, email: String) {
        updateViewArray.append((name,username,email))
    }
    
    
    
}
