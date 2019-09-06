//
//  Card.swift
//  Card
//
//  Created by Estevan Hernandez on 12/20/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

import UIKit

let kCardIndex = "kCardIndex"

@IBDesignable class Card: UIView {
	var view:UIView!
	var cardIndex:Int = 0
	let questions:Questions = sharedQuestions
	@IBOutlet var questionLabel:UILabel!
	@IBOutlet var currentCardLabel:UILabel!
	@IBOutlet var completedLabel:UILabel!
	
	@IBOutlet var prevCardButton:UIButton!
	@IBOutlet var nextCardButton:UIButton!
	@IBOutlet var completeCardButton:UIButton!
	@IBOutlet var recordButton:UIButton!
	@IBOutlet var playButton:UIButton!
	@IBOutlet var historyButton:UIButton!
	@IBOutlet weak var addCardButton: UIButton!
	
	var delegate:CardDelegate?
	
	
	func xibSetup() {
		
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
		view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0);
		view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
		view.layer.cornerRadius = 3
		// for grey circles
		/*
		let buttons = [prevCardButton, nextCardButton, completeCardButton, recordButton, playButton]
		for button in buttons {
			button?.layer.cornerRadius = 15.0
			button?.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
			button?.layer.borderWidth = 1.0
		}
		*/
		questions.register(callBack: questionsUnarchived)
		questions.register(callBack: questionsArchived)
		questions.unarchiveQuestions()
		
		setCardIndex(to: 0)
		addSubview(view)
		setupAccessibilityIDs()
	}
	
	func setupAccessibilityIDs() {
		self.playButton.accessibilityIdentifier = AccessibilityIDs.playButton
		self.recordButton.accessibilityIdentifier = AccessibilityIDs.recordButton
		self.nextCardButton.accessibilityIdentifier = AccessibilityIDs.nextCardButton
		self.prevCardButton.accessibilityIdentifier = AccessibilityIDs.prevCardButton
		self.completeCardButton.accessibilityIdentifier = AccessibilityIDs.completeCardButton
		self.completedLabel.accessibilityIdentifier = AccessibilityIDs.completedCardLabel
		self.historyButton.accessibilityIdentifier = AccessibilityIDs.historyButton
		self.questionLabel.accessibilityIdentifier = AccessibilityIDs.questionLabel
		
		self.addCardButton.accessibilityIdentifier = AccessibilityIDs.addCardButton
	}
	func loadViewFromNib() -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: "Card", bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		return view
	}
	override init(frame:CGRect) {
		super.init(frame: frame)
		xibSetup()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	func setCardIndex(to newIndex: NSInteger) {
		if (questions.queue.count > 0) {
			if (newIndex+1 <= questions.queue.count) {
				cardIndex = newIndex
			} else {
				cardIndex = questions.queue.count - 1
			}
		} else {
			cardIndex = 0
		}
		if (questions.queue.count > 0) {
			questionLabel.text = questions.queue[cardIndex]
			if (questionLabel.text?.contains("♢"))! {
				questionLabel.text = questionLabel.text?.appending("\n\n♢ = Ask another couple")
			}
		}
		currentCardLabel.text = "\(questions.queue.count)"
		completedLabel.text = "\(ButtonTitles.checkmark) \(questions.done.count)"
		
		// if its the first card, disable the previous button
		prevCardButton.isEnabled = !(cardIndex + 1 == 1) && questions.queue.count > 0
		// if its the last card, disable the next button
		nextCardButton.isEnabled = !(cardIndex + 1 == questions.queue.count) && questions.queue.count > 0
	}
	@IBAction func nextCardTapped(_ sender: UIButton) {
		if (cardIndex + 1 < questions.queue.count) {
			setCardIndex(to: cardIndex+1)
		}
	}
	@IBAction func previousCardTapped(_ sender: UIButton) {
		if (cardIndex > 0) {
			setCardIndex(to: cardIndex-1)
		}
	}
	@IBAction func markAsCompleteTapped(_ sender: UIButton) {
		if (questions.queue.count > 0) {
			questions.done.append(questions.queue[cardIndex])
			questions.queue.remove(at: cardIndex)
		} else {
			queueEmpty()
		}
		setCardIndex(to: cardIndex)
		questions.archiveQuestions()
		self.delegate?.markAsCompleteTapped(card: self)
	}
	@IBAction func recordTapped(_ sender: UIButton) {
		self.delegate?.recordTapped(card: self)
	}
	@IBAction func playTapped(_ sender: UIButton) {
		self.delegate?.playTapped(card: self)
	}
	@IBAction func addTapped(_ sender: UIButton) {
		self.delegate?.addTapped(card: self)
	}
	@IBAction func historyTapped(_ sender: UIButton) {
		self.delegate?.historyTapped(card: self)
	}
	// MARK: Questions Delegate
	func questionsArchived() {
		UserDefaults.standard.setValue(cardIndex, forKey: kCardIndex)
	}
	
	func questionsUnarchived() {
		self.questions.queue = questions.queue
		self.questions.done = questions.done
		//self.questions.userEnteredQs = questions.userEnteredQs
		if let cardIndex = UserDefaults.standard.value(forKey: kCardIndex) as? Int {
			self.cardIndex = cardIndex
		} else {
			self.cardIndex = 0
		}
		if self.questions.queue.count == 0 {
			queueEmpty()
		}
	}
	
	func queueEmpty() {
		self.questionLabel.text = ""
		self.recordButton.isEnabled = false
		self.playButton.isEnabled = false
		self.completeCardButton.isEnabled = false
	}
}

protocol CardDelegate {
	func recordTapped(card: Card)
	func playTapped(card: Card)
	func addTapped(card: Card)
	func historyTapped(card: Card)
	func markAsCompleteTapped(card: Card)
}
