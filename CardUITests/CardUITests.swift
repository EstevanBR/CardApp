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
		var beforeCount:Int!
		var afterCount:Int!
		
		_ = QuestionsPage()
		.tapAnswerCell()
		.getCompletedCardsCount(with: { (count) in
			beforeCount = count
		}).tapCompleteCardButton()
		.getCompletedCardsCount(with: { (count) in
			afterCount = count
		})
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
	
	func testTapHistoryWhileRecording() {
		_ = QuestionsPage()
		.tapAnswerCell()
		.tapRecordButton()
		.dismissViewSwipe()
		.tapAnswerCell()
	}	
}
