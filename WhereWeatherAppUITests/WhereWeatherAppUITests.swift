//
//  WhereWeatherAppUITests.swift
//  WhereWeatherAppUITests
//
//  Created by Tony Lieu on 9/18/24.
//

import XCTest
@testable import WhereWeatherApp

final class WhereWeatherAppUITests: XCTestCase {

    let sut = XCUIApplication()
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        sut.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchBar() {
        let searchBar = sut.searchFields.firstMatch
        searchBar.tap()
        searchBar.typeText("Atlanta")
        sut.keyboards.buttons["search"].tap()
        XCTAssertEqual(sut.staticTexts.firstMatch.label, "Atlanta")
    }
}
