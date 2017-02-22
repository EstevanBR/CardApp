//
//  Card.swift
//  Card
//
//  Created by Estevan Hernandez on 12/20/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

import UIKit

let kCardIndex = "kCardIndex"

@IBDesignable class Card: UIView, QuestionsDelegate {
	var view:UIView!
	var cardIndex:Int = 0
	let questions:Questions = Questions()
	@IBOutlet var questionLabel:UILabel!
	@IBOutlet var currentCardLabel:UILabel!
	@IBOutlet var completedLabel:UILabel!
	
	@IBOutlet var prevCardButton:UIButton!
	@IBOutlet var nextCardButton:UIButton!
	@IBOutlet var completeCardButton:UIButton!
	@IBOutlet var recordButton:UIButton!
	@IBOutlet var playButton:UIButton!
	
	var delegate:CardDelegate?
	
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
		view.layer.cornerRadius = 8.0
		view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0);
		view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
		view.layer.borderColor = UIColor.black.cgColor
		view.layer.borderWidth = 1.0
		questions.unarchiveQuestions()
		questions.delegate = self
		questions.queue.append(contentsOf: Questions.questionList())
		setCardIndex(to: 0)
		addSubview(view)
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
		currentCardLabel.text = "\(questions.queue.count) left"
		completedLabel.text = "\(questions.done.count) done"
		
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
		}
		setCardIndex(to: cardIndex)
		questions.archiveQuestions()
	}
	@IBAction func recordTapped(_ sender: UIButton) {
		print("record tapped")
		if let delegate = self.delegate {
			delegate.recordTapped(card: self)
		} else {
			print("no delegate")
		}
	}
	@IBAction func playTapped(_ sender: UIButton) {
		print("play tapped")
		if let delegate = self.delegate {
			delegate.playTapped(card: self)
		} else {
			print("no delegate")
		}
	}
	func questionsArchived() {
		UserDefaults.standard.setValue(cardIndex, forKey: kCardIndex)
	}
	
	func questionsUnarchived(questions: Questions) {
		self.questions.queue = questions.queue
		self.questions.done = questions.done
		UserDefaults.standard.value(forKey: kCardIndex);
	}
}

protocol CardDelegate {
	func recordTapped(card: Card)
	func playTapped(card: Card)
}
