//
//  MobileBuyersGuideUITests.swift
//  MobileBuyersGuideUITests
//
//  Created by Atikur Rahman on 13/8/21.
//

import XCTest

class MobileBuyersGuideUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // test if Sort button tap shows alert
    func testSortButtonShowAlert() throws {
        app.navigationBars["MobileBuyersGuide.MobileList"].buttons["Sort"].tap()
        XCTAssertTrue(app.alerts["Sort"].exists)
        app.alerts["Sort"].buttons["Cancel"].tap()
    }
}
