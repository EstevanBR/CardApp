//
//  CardUITests.swift
//  CardUITests
//
//  Created by Estevan Hernandez on 6/30/17.
//  Copyright © 2017 Estevan Hernandez. All rights reserved.
//

import XCTest

class CardUITests: XCTestCase {
	
	
	let recordingDuration:TimeInterval = 2.0
	
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
		var firstQuestionText:String!
		var secondQuestionText:String!
		
		_ = QuestionsPage()
			.tapAnswerCell()
			.getQuestionText(with: { (text) in
				firstQuestionText = text
			})
			.tapNextCardButton()
			.getQuestionText(with: { (text) in
				secondQuestionText = text
			})
		
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
	
//	func testHistoryButton() {
//		_ = QuestionsPage()
//			.tapAnswerCell()
//			.tapHistoryButton()
//	}
	
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
	
//	func testAddCardButton() {
//		let app = XCUIApplication()
//		
//		_ = QuestionsPage()
//			.tapAnswerCell()
//			.tapAddCardbutton()
//		
//		XCTAssertEqual(app.alerts.firstMatch.label, ButtonTitles.add)
//		XCTAssertTrue(app.alerts.firstMatch.buttons[ButtonTitles.checkmark].exists)
//		XCTAssertTrue(app.alerts.firstMatch.buttons[ButtonTitles.close].exists)
//	}
	
	func testFinishPlaying() {
		testRecord()
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapPlayButton()
			.tapDefault()
			.wait(for: recordingDuration + 1)
	}
	
	func testCompleteAllQuestions() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.getCurrentCardNumber(with: { (number) in
				for _ in 1...number {
					 _ = CardPage().tapCompleteCardButton()
				}
			})
		XCTAssertNoThrow(QuestionsPage())
	}
	
	func testQuestionCellPlayButton() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapRecordButton()
			.wait(for: recordingDuration)
			.tapRecordButton()
			.tapCompleteCardButton()
			.dismissViewSwipe()
			.tapQuestionCellPlayButton()
	}
	
	func testTapHistoryWhileRecording() {
		_ = QuestionsPage()
			.tapAnswerCell()
			.tapRecordButton()
			.dismissViewSwipe()
			.tapAnswerCell()
	}
	
//	func testAddCard() {
//		var beforeCardCount:Int = 0
//		var afterCardCount:Int = 0
//		
//		let newQuestionText = "Test Add Card?"
//		
//		var beforeQuestionText:String!
//		var afterQuestionText:String!
//		_ = QuestionsPage()
//			.tapAnswerCell()
//			.getCurrentCardNumber(with: { (cardCount) in
//				beforeCardCount = cardCount
//			})
//			.getQuestionText(with: { (text) in
//				beforeQuestionText = text
//			})
//			.tapAddCardbutton()
//			.enterQuestionText(text: newQuestionText)
//			.tapOkButton()
//			.getQuestionText(with: { (text) in
//				afterQuestionText = text
//			})
//			.getCurrentCardNumber(with: { (cardCount) in
//				afterCardCount = cardCount
//			})
//		
//		XCTAssertEqual(afterQuestionText, newQuestionText)
//		XCTAssertNotEqual(beforeQuestionText, afterQuestionText)
//		XCTAssertGreaterThan(afterCardCount, beforeCardCount)
//	}
}
