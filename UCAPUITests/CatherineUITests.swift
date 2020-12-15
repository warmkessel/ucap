//
//  CatherineUITests.swift
//  CatherineUITests
//
//  Created by James Warmkessel on 11/20/20.
//

import XCTest

class CatherineUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReportGood() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
            app.launch()
            let reportShowButton  = app.tabBars["Tab Bar"].buttons["Report"]
            XCTAssertTrue(reportShowButton.waitForExistence(timeout: 5))
            reportShowButton.tap()
            XCTAssertTrue(app.buttons["good"].waitForExistence(timeout: 5))
            app.staticTexts["Good"].tap()
            XCTAssertTrue(app.buttons["respond"].waitForExistence(timeout: 5))
            app.buttons["respond"].tap()
            XCTAssertTrue(app.buttons["poor"].waitForExistence(timeout: 5))

    }
    func testReportPoor() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
            app.launch()
            let reportShowButton  = app.tabBars["Tab Bar"].buttons["Report"]
            XCTAssertTrue(reportShowButton.waitForExistence(timeout: 5))
            reportShowButton.tap()
            XCTAssertTrue(app.buttons["poor"].waitForExistence(timeout: 5))
            app.staticTexts["Poor"].tap()
            XCTAssertTrue(app.buttons["respond"].waitForExistence(timeout: 5))
            app.buttons["respond"].tap()
            XCTAssertTrue(app.buttons["poor"].waitForExistence(timeout: 5))

    }
    func testSlideShow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
            app.launch()
        let slideShowButton  = app.tabBars["Tab Bar"].buttons["Slide Show"]
        XCTAssertTrue(slideShowButton.waitForExistence(timeout: 5))
        slideShowButton.tap()
        XCTAssertTrue(app.buttons["speaker"].waitForExistence(timeout: 5))
        app.buttons["speaker"].tap()
        XCTAssertTrue(app.buttons["mute"].waitForExistence(timeout: 5))
        app.buttons["mute"].tap()
    }
    func testSelfie() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
            app.launch()
        let selfieShowButton  = app.tabBars["Tab Bar"].buttons["Selfie"]
        XCTAssertTrue(selfieShowButton.waitForExistence(timeout: 5))
        selfieShowButton.tap()
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.images["person"]/*[[".images[\"recenter\"]",".images[\"person\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 5))
        app/*@START_MENU_TOKEN@*/.images["person"]/*[[".images[\"recenter\"]",".images[\"person\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.images["camera.circle"].waitForExistence(timeout: 5))
        app.images["camera.circle"].tap()
        //app.alerts["“Catherine” Would Like to Add to your Photos"].scrollViews.otherElements.buttons["OK"].tap()
        
    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
