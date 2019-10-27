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
		QuestionsPage()
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
			.end()
    }
	func testRecord() {
		QuestionsPage()
			.tapAnswerCell()
			.wait(for: recordingDuration, before: {
				CardPage().tapRecordButton()
			}, after: {
				CardPage().tapRecordButton()
			})
		CardPage().dismissViewSwipe()
	}
	func testPlay() {
		QuestionsPage()
			.tapAnswerCell()
			.tapPlayButton()
			.tapDefault()
			.tapPlayButton()
			.tapSpeakerButton()
			.end()
		
		
				
		
	}

	func testRecordAndPlay() {
		testRecord()
		testPlay()
	}
	
	func testMarkCardAsCompleted() {
		QuestionsPage()
			.tapAnswerCell()
			.tapCompleteCardButton()
			.end()
	}
	
	func testAppStates() {
		let app = XCUIApplication()

		app.terminate()
		app.launch()
		
		XCUIDevice.shared.press(.home)
		app.activate()
	}
}

protocol Page {
	var root:String { get }
	var element:XCUIElement { get }
}

extension Page {
	var app:XCUIApplication {
		return XCUIApplication()
	}
	
	var element: XCUIElement {
		return app.otherElements[root]
	}
	
	func wait(for duration: TimeInterval, before: ()->Void, after: ()->Void) -> Page {
		app.tap()
		before()
		RunLoop.current.run(until: Date.init(timeIntervalSinceNow: duration))
		after()
		return self
	}
	
	func tap(buttonWithAccessibilityIdentifier accessibilityIdentifier:String) {
		app.buttons[accessibilityIdentifier].tap()
	}
	func tap(cellWithAccessibilityIdentifier accessibilityIdentifier:String) {
		app.tables.cells[accessibilityIdentifier].tap()
	}
	func end() {
		
	}
}


class CardPage:Page {
	var root:String = "CardView.view"
	private var prevCardButton = "CardView.prevCardButton"
	private var nextCardButton = "CardView.nextCardButton"
	private var completeCardButton = "CardView.completeCardButton"
	private var recordButton = "CardView.recordButton"
	private var playButton = "CardView.playButton"
	private var historyButton = "CardView.historyButton"
	private var addCardButton = "CardView.addCardButton"
	
	func tapPlayButton() -> AudioOutputPage {
		tap(buttonWithAccessibilityIdentifier: playButton)
		return AudioOutputPage()
	}
	
	func tapRecordButton() -> CardPage {
		tap(buttonWithAccessibilityIdentifier: recordButton)
		return CardPage()
	}
	
	func tapNextCardButton() -> CardPage {
		tap(buttonWithAccessibilityIdentifier: nextCardButton)
		return CardPage()
	}
	
	func tapPreviousCardButton() -> CardPage{
		tap(buttonWithAccessibilityIdentifier: prevCardButton)
		return CardPage()
	}
	
	func dismissViewSwipe()->QuestionsPage {
		element.swipeDown()
		return QuestionsPage()
	}
	
	func tapCompleteCardButton() -> CardPage {
		tap(buttonWithAccessibilityIdentifier: completeCardButton)
		return CardPage()
	}
}

class QuestionsPage: Page {
	var root: String = "QuestionsTableViewController.tableView"
	var element: XCUIElement {
		return app.tables[root]
	}
	
	private var questionCell = "QuestionCell.view"
	private var questionCellPlayButton = "QuestionCell.playButton"
	private var answerCell = "AnswerCell.view"
	
	func tapAnswerCell() -> CardPage{
		tap(cellWithAccessibilityIdentifier: answerCell)
		return CardPage()
	}
	func tapQuestionCell() -> QuestionsPage {
		tap(cellWithAccessibilityIdentifier: questionCell)
		return QuestionsPage()
	}
	func tapQuestionCellPlayButton() -> QuestionsPage {
		app.buttons[questionCellPlayButton].tap()
		
		return QuestionsPage()
	}
}

class AudioOutputPage: Page {
	var root: String = "Audio Output"
	private var defaultButton = "Default"
	private var speakerButton = "Speaker"
	
	var element: XCUIElement {
		return app.sheets.firstMatch
	}
	func tapDefault() -> CardPage {
		app.buttons.element(matching: NSPredicate(format: "\"\(defaultButton)\" IN titles")).tap()
		//app.buttons[defaultButton].tap()
		return CardPage()
	}
	func tapSpeakerButton() -> CardPage {
		
		return CardPage()
	}
}

