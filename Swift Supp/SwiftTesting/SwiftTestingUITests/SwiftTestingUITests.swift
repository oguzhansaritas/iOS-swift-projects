//
//  SwiftTestingUITests.swift
//  SwiftTestingUITests
//
//  Created by OGUZHAN SARITAS.
//

import XCTest

final class SwiftTestingUITests: XCTestCase {


    func testToDoItem() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
                
        let addButton = app.navigationBars["SwiftTesting.View"].buttons["Add"]
        
        let elementsQuery = app.alerts["Add Item"].scrollViews.otherElements
        let textField = elementsQuery.collectionViews.textFields["Enter Item"]
        
        let okbutton = elementsQuery.buttons["OK"]
        let addedCell = app.tables.cells.containing(.staticText,identifier: "Helloooo RPA").element
        
        addButton.tap()
        textField.tap()
        textField.typeText("Helloooo RPA")
        okbutton.tap()
        XCTAssertTrue(addedCell.exists)
                // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDeleteItem() throws{

        
        let app = XCUIApplication()
        app.launch()
        let addButton = app.navigationBars["SwiftTesting.View"].buttons["Add"]
        
        let elementsQuery = app.alerts["Add Item"].scrollViews.otherElements
        let textField = elementsQuery.collectionViews.textFields["Enter Item"]
        
        let okbutton = elementsQuery.buttons["OK"]
        let addedCell = app.tables.cells.containing(.staticText,identifier: "Helloooo").element
        
        let tablesQuery = app.tables
        let deleteButton = tablesQuery.buttons["Delete"]
        
        
        addButton.tap()
        textField.tap()
        textField.typeText("Helloooo")
        okbutton.tap()
        addedCell.swipeLeft()
        deleteButton.tap()
        XCTAssertFalse(addedCell.exists)
                
        
    }

}
