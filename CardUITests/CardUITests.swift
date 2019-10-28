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
	
	let recordingDuration:TimeInterval = 5.0
	
    override func setUp() {
		super.setUp()
		app.launchArguments.append(TestLaunchArguments.reset.rawValue)
		app.launch()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
		app.terminate()
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
//	func testCardNumberChangesWhenTappingArrows() {
//		print("This isn't actually a feature :D")
//		return
//		let before:Int = QuestionsPage()
//			.tapAnswerCell()
//			.getCurrentCardNumber()
//
//		let after:Int = CardPage()
//			.tapNextCardButton()
//			.getCurrentCardNumber()
//
//		XCTAssertGreaterThan(after, before, "Card number did not change")
//	}
	
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
			.wait(for: recordingDuration, before: {
				_ = CardPage().tapRecordButton()
			}, after: {
				_ = CardPage().tapRecordButton()
			})
		_ = CardPage().dismissViewSwipe()
	}
	
	#if targetEnvironment(simulator)
	func testPlay() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapPlayButton()
	}
	#else
	func testPlay() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapPlayButton()
			.tapDefault()
			.tapPlayButton()
			.tapSpeakerButton()
	}
	#endif

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
			.wait(for: 8.0, before: {
				_ = CardPage().tapRecordButton()
			}, after: {
				_ = CardPage().tapRecordButton()
			})
		_ = CardPage().wait(for: 2.0, before: {
			_ = CardPage().tapPlayButton()
		}, after: {
			_ = CardPage().tapPlayButton()
		})
	}
}
