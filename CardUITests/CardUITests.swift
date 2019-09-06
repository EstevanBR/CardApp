//
//  CardUITests.swift
//  CardUITests
//
//  Created by Estevan Hernandez on 6/30/17.
//  Copyright © 2017 Estevan Hernandez. All rights reserved.
//

import XCTest

class CardUITests: XCTestCase {
	let app = XCUIApplication()
	
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testArrows() {
		app.tables.cells.firstMatch.tap()
		
		let nextcardbuttonButton = app.buttons[AccessibilityIDs.nextCardButton]
		let previouscardbuttonButton = app.buttons[AccessibilityIDs.prevCardButton]
		
		//XCTAssert(previouscardbuttonButton.staticTexts[ButtonTitles.leftArrow].exists)
		//XCTAssert(nextcardbuttonButton.staticTexts[ButtonTitles.rightArrow].exists)
		
		XCTAssert(!previouscardbuttonButton.isEnabled)
		
		nextcardbuttonButton.tap()
		XCTAssert(previouscardbuttonButton.isEnabled)
		XCTAssert(nextcardbuttonButton.isEnabled)
		
		previouscardbuttonButton.tap()
		XCTAssert(!previouscardbuttonButton.isEnabled)
		
    }
	func testRecord() {
		app.tables.cells.firstMatch.tap()
		
		let recordButton = app.buttons[AccessibilityIDs.recordButton]
		//XCTAssert(recordButton.title == ButtonTitles.record)
		recordButton.tap()
		//XCTAssert(recordButton.title == ButtonTitles.stop)
		sleep(10)
		recordButton.tap()
		//XCTAssert(recordButton.title == ButtonTitles.record)
	}
	func testPlay() {
		app.tables.cells.firstMatch.tap()
		
		XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["playButton"]/*[[".buttons[\"▷\"]",".buttons[\"playButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
		//XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["playButton"]/*[[".buttons[\"▷\"]",".buttons[\"playButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		
//		let playButton = app.buttons[AccessibilityIDs.playButton]
//		playButton.tap()
//
//		let audioOutputSheet = app.sheets["Audio Output"]
//		let defaultButton = audioOutputSheet.buttons["Default"]
//		defaultButton.tap()
//
//		sleep(12)
//		playButton.tap()
//
//		let speakerButton = audioOutputSheet.buttons["Speaker"]
//		speakerButton.tap()
//		playButton.tap()
//		defaultButton.tap()
//		playButton.tap()
//		speakerButton.tap()
	}
	
	func testMarkCardAsCompleted() {
		app.tables.cells.firstMatch.tap()
		
		let completeButton = app.buttons[AccessibilityIDs.completeCardButton]
		completeButton.tap()
		
		let historyButton = app.buttons[AccessibilityIDs.historyButton]
		historyButton.tap()
		
	}
	
	func testAppStates() {
		app.terminate()
		app.launch()
		
		XCUIDevice.shared.press(.home)
		app.activate()
	}
	
	func testAddCard() {
		app.tables.cells.firstMatch.tap()
		
		let app = XCUIApplication()
		let button = app.buttons[AccessibilityIDs.addCardButton]
		button.tap()
		
		let alert = app.alerts[ButtonTitles.add]
		alert.textFields.firstMatch.typeText("test1234")
		alert.buttons[ButtonTitles.checkmark].tap()
		
		button.tap()
		alert.textFields.firstMatch.typeText("test4321")
		alert.buttons["ⅹ"].tap()
		
		
	}
	
	func testTapHistory() {
		app.tables/*@START_MENU_TOKEN@*/.buttons["▷"]/*[[".cells[\"questionCell\"].buttons[\"▷\"]",".buttons[\"▷\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
		app.navigationBars["Card.QuestionsTableView"].buttons["Back"].tap()
		
	}
	
	func testRecordAndPlayAudio() {
		testRecord()
		testPlay()
	}
}
