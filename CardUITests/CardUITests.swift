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
		let app = XCUIApplication()
		app.launchArguments.append(TestLaunchArguments.reset.rawValue)
		app.launch()
        continueAfterFailure = false
    }

    func testArrows() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapNextCardButton()
			.tapNextCardButton()
			.tapNextCardButton()
			.tapNextCardButton()
			.tapNextCardButton()
			.tapNextCardButton()
			.tapPreviousCardButton()
			.tapPreviousCardButton()
			.tapPreviousCardButton()
			.tapPreviousCardButton()
			.tapPreviousCardButton()
			.tapPreviousCardButton()
			.tapPreviousCardButton()
    }
	
	func testQuestionTextChangesWhenTappingArrows() {
		let firstQuestionText:String = QuestionsPage()
			.tapAnswerCell()
			.getQuestionText()
		
		let secondQuestionText:String = CardPage()
			.tapNextCardButton()
			.getQuestionText()
		XCTAssertNotEqual(firstQuestionText, secondQuestionText, "Question text did not change")
	}
	
	func testCompletedCardsCountChangesWhenCompletingCard() {
		let beforeCount:Int = QuestionsPage()
			.tapAnswerCell()
			.getCompletedCardsCount()
		let afterCount:Int = CardPage()
			.tapCompleteCardButton()
			.getCompletedCardsCount()
		XCTAssertGreaterThan(afterCount, beforeCount, "Completed count did not change")
	}
	func testRecord() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapRecordButton()
			.wait(for: recordingDuration)
			.tapRecordButton()
			.dismissViewSwipe()
	}
	
	func testPlay() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapPlayButton()
			.tapDefault()
			.tapStopButton()
			.tapPlayButton()
			.tapSpeakerButton()
	}
	func testRecordAndPlay() {
		testRecord()
		testPlay()
	}
	
	func testMarkCardAsCompleted() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapCompleteCardButton()
	}
	
	func testAppStates() {
		let app = XCUIApplication()

		app.terminate()
		app.launch()
		
		XCUIDevice.shared.press(.home)
		app.activate()
	}
	
	func testHistoryButton() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapHistoryButton()
	}
	
	func testStopPlaying() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapRecordButton()
			.wait(for: recordingDuration)
			.tapRecordButton()
			.tapPlayButton()
			.tapDefault()
			.wait(for: recordingDuration * 0.25)
			.tapStopButton()
	}
	
	func testAddCardButton() {
		let app = XCUIApplication()
		
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapAddCardbutton()
		
		XCTAssertEqual(app.alerts.firstMatch.label, ButtonTitles.add)
		XCTAssertTrue(app.alerts.firstMatch.buttons[ButtonTitles.checkmark].exists)
		XCTAssertTrue(app.alerts.firstMatch.buttons[ButtonTitles.close].exists)
	}
	
	func testFinishPlaying() {
		testRecord()
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapPlayButton()
			.wait(for: recordingDuration)
	}
}
