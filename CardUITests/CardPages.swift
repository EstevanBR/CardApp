//
//  CardPages.swift
//  CardUITests
//
//  Created by Estevan Hernandez on 10/27/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import XCTest

class CardPage:Page {
	var root:String = "CardView.view"
	private var prevCardButton = "CardView.prevCardButton"
	private var nextCardButton = "CardView.nextCardButton"
	private var completeCardButton = "CardView.completeCardButton"
	private var recordButton = "CardView.recordButton"
	private var playButton = "CardView.playButton"
	private var historyButton = "CardView.historyButton"
	private var addCardButton = "CardView.addCardButton"
	
	private var questionLabel = "CardView.questionLabel"
    private var currentCardLabel = "CardView.currentCardLabel"
    private var completedLabel = "CardView.completedLabel"
	
	func tapPlayButton() -> AudioOutputPage {
		tap(buttonWithAccessibilityIdentifier: playButton)
		return AudioOutputPage()
	}
	
	func tapRecordButton() -> CardPage {
		tap(buttonWithAccessibilityIdentifier: recordButton)
		return CardPage()
	}
	
	func tapNextCardButton() -> CardPage {
		_ = wait(for: 0.5, before: {
			tap(buttonWithAccessibilityIdentifier: nextCardButton)
		})
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
		_ = wait(for: 0.5, before: {
			tap(buttonWithAccessibilityIdentifier: completeCardButton)
		})
		return CardPage()
	}
	func getQuestionText() -> String {
		return element.staticTexts[questionLabel].label
	}
	func getCurrentCardNumber() -> Int {
		return Int(element.staticTexts[currentCardLabel].label)!
	}
	func getCompletedCardsCount() -> Int {
		return Int(element.staticTexts[completedLabel].label.split(separator: " ").last!)!
	}
	func tapHistoryButton() -> QuestionsPage {
		tap(buttonWithAccessibilityIdentifier: historyButton)
		return QuestionsPage()
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
