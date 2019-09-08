//
//  CardUITests.swift
//  CardUITests
//
//  Created by Estevan Hernandez on 6/30/17.
//  Copyright © 2017 Estevan Hernandez. All rights reserved.
//

import XCTest

class CardUITests: XCTestCase {
	let recordingDuration:TimeInterval = 5.0
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
		
		XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testArrows() {
		
		let app = XCUIApplication()
		app.tables.staticTexts["Answer a Question"].tap()
		
		sleep(1)
		XCTAssertFalse(app.buttons["previousCardButton"].isEnabled)
		XCTAssertTrue(app.buttons["nextCardButton"].isEnabled)
		
		app.buttons["nextCardButton"].tap()
		
		sleep(1)
		XCTAssertTrue(app.buttons["previousCardButton"].isEnabled)
		XCTAssertTrue(app.buttons["nextCardButton"].isEnabled)
		
		app.buttons["previousCardButton"].tap()
		sleep(1)
		XCTAssertFalse(app.buttons["previousCardButton"].isEnabled)
		XCTAssertTrue(app.buttons["nextCardButton"].isEnabled)
		
    }
	func testRecord() {
		let app = XCUIApplication()
		app.tables.staticTexts["Answer a Question"].tap()
		
		let recordButton = app.buttons[AccessibilityIDs.recordButton]
		
		app.tap()
		
		recordButton.tap()
		
		wait(for: recordingDuration)
		//sleep(duration)
		
		recordButton.tap()
	}
	func testPlay() {
		
		
		let app = XCUIApplication()
		app.tables/*@START_MENU_TOKEN@*/.staticTexts["Answer a Question"]/*[[".cells[\"answerCell\"].staticTexts[\"Answer a Question\"]",".staticTexts[\"Answer a Question\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		let playbuttonButton = app.buttons["playButton"]
		app.tap()
		playbuttonButton.tap()
		
		let audioOutputSheet = app.sheets["Audio Output"]
		let defaultButton = audioOutputSheet.buttons["Default"]
		app.tap()
		defaultButton.waitForExistence(timeout: 2.0)
		defaultButton.tap()
		
		app.tap()
		wait(for: recordingDuration + 1.0)
		
		playbuttonButton.tap()
		app.tap()
		audioOutputSheet.buttons["Speaker"].tap()
		
		app.tap()
		wait(for: recordingDuration / 2)
		
		app.buttons["playButton"].tap()
		defaultButton.tap()
	}
	
	func testRecordAndPlay() {
		testRecord()
		XCUIApplication().swipeDown()
		testPlay()
	}
	
	func testMarkCardAsCompleted() {
		let app = XCUIApplication()
		app.tables.staticTexts["Answer a Question"].tap()
		
		let completeButton = app.buttons[AccessibilityIDs.completeCardButton]
		completeButton.tap()
		
		let historyButton = app.buttons[AccessibilityIDs.historyButton]
		historyButton.tap()
		
	}
	
	func testAppStates() {
		let app = XCUIApplication()

		app.terminate()
		app.launch()
		
		XCUIDevice.shared.press(.home)
		app.activate()
	}
	
	func testTapPlayInQuestionCell() {
		
		XCUIApplication().tables.cells.containing(.staticText, identifier:"What do you imagine an average night at our place would be?").buttons["▷"].tap()
		
		
	}
	
	func wait(for duration: TimeInterval) {
		let waitExpectation = expectation(description: "Waiting")
		waitExpectation.isInverted = true
		waitExpectation.expectedFulfillmentCount = 1
		//waitForExpectations(timeout: duration)
		let result = XCTWaiter.wait(for: [waitExpectation], timeout: duration)
		if result == .timedOut {
			print("time")
			return
		}
	}
}
