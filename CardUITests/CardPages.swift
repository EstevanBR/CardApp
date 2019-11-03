//
//  CardPages.swift
//  CardUITests
//
//  Created by Estevan Hernandez on 10/27/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import XCTest

struct CardPage:Page {
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
	
	func tapStopButton() -> CardPage {
		tap(buttonWithName: ButtonTitles.stop)
		return CardPage()
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
	
	func tapAddCardbutton() -> AddCardPage {
		tap(buttonWithAccessibilityIdentifier: addCardButton)
		return AddCardPage()
	}
	func getQuestionText(with: (String)->()) -> CardPage {
		with(element.staticTexts[questionLabel].label)
		return CardPage()
	}
	func getCurrentCardNumber(with: (Int)->()) -> CardPage {
		with(Int(element.staticTexts[currentCardLabel].label)!)
		return CardPage()
	}
	func getCompletedCardsCount() -> Int {
		return Int(element.staticTexts[completedLabel].label.split(separator: " ").last!)!
	}
	func tapHistoryButton() -> QuestionsPage {
		tap(buttonWithAccessibilityIdentifier: historyButton)
		return QuestionsPage()
	}
}

struct QuestionsPage: Page {
	var root: String = "QuestionsTableViewController.view"
	var element: XCUIElement {
		return app.tables[root]
	}
	
	private var questionCell = "QuestionCell"
	private var questionCellPlayButton = "QuestionCell.playButton"
	private var answerCell = "AnswerCell"
	
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

struct AudioOutputPage: Page {
	var root: String = "Audio Output"
	private var defaultButton = "Default"
	private var speakerButton = "Speaker"
	
	var element: XCUIElement {
		return app.sheets.firstMatch
	}
	func tapDefault() -> CardPage {
		element.buttons[defaultButton].firstMatch.tap()

		return CardPage()
	}
	func tapSpeakerButton() -> CardPage {
		element.buttons[speakerButton].firstMatch.tap()

		return CardPage()
	}
}

struct AddCardPage: Page {
	var root: String = ButtonTitles.add
	private var okButton:String = ButtonTitles.checkmark
	private var closeButton:String = ButtonTitles.close
	
	var element: XCUIElement {
		return app.alerts[root].firstMatch
	}
	
	func tapOkButton() -> CardPage {
		element.buttons[okButton].firstMatch.tap()
		return CardPage()
	}
	
	func tapCloseButton() -> CardPage {
		element.buttons[closeButton].firstMatch.tap()
		return CardPage()
	}
	
	func enterQuestionText(text:String) -> AddCardPage {
		element.textFields.firstMatch.typeText(text)
		return AddCardPage()
	}
}
