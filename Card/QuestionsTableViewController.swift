//
//  QuestionsTableViewController.swift
//  Card
//
//  Created by Estevan Hernandez on 8/30/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import Foundation
import UIKit
import os.log

class QuestionsTableViewController: UITableViewController, QuestionCellDelegate, CustomReflectable {

	public var customMirror: Mirror {
		return Mirror(self, children:[
			"tableView": tableView!
		])
	}
	let questions:Questions = Questions.shared
	let questionCell = "questionCell"
	let answerCell = "answerCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		questions.register(callBack: questionsUnarchived)
		questions.register(callBack: questionsArchived)
		//debugAccessibility()
		
		//view.injectAccessibilityIdentifiers()
		injectAccessibilityIdentifiers()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//questions.delegate = self
		
		questions.unarchiveQuestions()
		
		self.navigationController?.setNavigationBarHidden(false, animated: false)
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		if questions.done.count > 0 {
			return 2
		} else {
			return 1
		}
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else {
			return questions.done.count
		}
		
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			let cell:QuestionCell = (tableView.dequeueReusableCell(withIdentifier: questionCell, for: indexPath) as? QuestionCell)!
			cell.questionLabel.text = questions.done[indexPath.row]
			cell.delegate = self
			cell.injectAccessibilityIdentifiers()
			return cell
		} else {
			let cell:AnswerCell = (tableView.dequeueReusableCell(withIdentifier: answerCell, for: indexPath) as? AnswerCell)!
			cell.injectAccessibilityIdentifiers()
			return cell
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return ["QUESTION","ANSWERS"][section]
	}
	
	func playTapped(questionCell: QuestionCell) {
		if let parentVC:CardViewController = parent as? CardViewController {
			parentVC.startPlaying(answerForQuestion: questionCell.questionLabel.text!)
		}
	}

	func questionsArchived() {
		self.tableView.reloadData()
	}
	
	func questionsUnarchived() {
		self.tableView.reloadData()
	}
}

class QuestionCell: UITableViewCell {
	
	@IBOutlet var questionLabel:UILabel!
	@IBOutlet var playButton:UIButton!
	
	var delegate: QuestionCellDelegate?
	@IBAction func playTapped(_ sender: UIButton) {
		self.delegate?.playTapped(questionCell: self)
	}
}

extension QuestionCell: CustomReflectable {
	var customMirror: Mirror {
		return Mirror(self, children:[
			"view":self,
			"questionLabel":questionLabel!,
			"playButton":playButton!
		])
	}
}

protocol QuestionCellDelegate {
	func playTapped(questionCell: QuestionCell)
}

class AnswerCell:UITableViewCell,CustomReflectable {
	var customMirror: Mirror {
		return Mirror(self, children:[
			"view":self,
			"textLabel":textLabel!
		])
	}
}
