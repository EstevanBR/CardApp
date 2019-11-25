//
//  QuestionsTests.swift
//  CardTests
//
//  Created by Estevan Hernandez on 11/3/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import XCTest

@testable import Card

class QuestionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testQuestionListHasTenItems() {
		XCTAssertEqual(Questions.questionList().count, 10)
	}
	
	func testCallBacksTriggeredWhenQuestionsArchived() {
		var callBackCalled:Bool = false
		
		Questions.shared.register {
			callBackCalled = true
		}
		
		Questions.shared.archiveQuestions()
		
		XCTAssertTrue(callBackCalled)
	}
	
	func testQueueFilePath() {
		XCTAssertEqual(Questions.shared.queueFilePath.split(separator: "/").last, "queue")
	}
	
	func testDoneFilePath() {
		XCTAssertEqual(Questions.shared.doneFilePath.split(separator: "/").last, "done")
	}
	
	func testMasterFilePath() {
		XCTAssertEqual(Questions.shared.masterFilePath.split(separator: "/").last, "master")
	}
	
	func testCallBacksTriggeredWhenQuestionsUnarchived() {
		var callBackCalled:Bool = false
		
		Questions.shared.register {
			callBackCalled = true
		}
		
		Questions.shared.unarchiveQuestions()
		
		XCTAssertTrue(callBackCalled)
	}
	
	func testAbsoluteIndexForCard() {
		XCTAssertEqual(Questions.shared.absoluteIndex(forCardText: "question 2?"), 1)
	}
	
	func testQuestionListAndMasterAreTheSameAfterInit() {
		XCTAssertEqual(Questions.questionList(), Questions.shared.masterList)
	}
	
	func testArchiveAndUnarchive() {
		XCTAssertNoThrow(Questions.shared.archiveQuestions())
		XCTAssertNoThrow(Questions.shared.unarchiveQuestions())
	}
	
	func testIsRunningTests() {
		XCTAssertTrue(Questions.isRunningTests())
	}
}
