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
import AAII

enum SectionType:Int {
	case answer = 0
	case question = 1
}
class QuestionsTableViewController: UITableViewController {
	let questions:Questions = Questions.shared
	let questionCell = "questionCell"
	let answerCell = "answerCell"
	
	var sections:[SectionType] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		questions.register(callBack: questionsUnarchived)
		questions.register(callBack: questionsArchived)
		
		injectAccessibilityIdentifiers()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//questions.delegate = self
		
		questions.unarchiveQuestions()
		
		self.navigationController?.setNavigationBarHidden(false, animated: false)
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		sections = []
		
		if questions.queue.count > 0 {
			sections.append(SectionType.answer)
		}
		
		if questions.done.count > 0 {
			sections.append(SectionType.question)
		}
		
		return sections.count
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		var rows:Int = 0
		
		if sections[section] == SectionType.answer {
			rows = (questions.queue.count > 1) ? 1 : 0
		} else if sections[section] == SectionType.question {
			rows =  questions.done.count
		}
		
		return rows;
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if sections[indexPath.section] == SectionType.answer {
			let cell:AnswerCell = tableView.dequeueReusableCell(withIdentifier: answerCell, for: indexPath) as! AnswerCell
			cell.injectAccessibilityIdentifiers()
			return cell
		} else if sections[indexPath.section] == SectionType.question {
			let cell:QuestionCell = tableView.dequeueReusableCell(withIdentifier: questionCell, for: indexPath) as! QuestionCell
			cell.questionLabel.text = questions.done[indexPath.row]
			cell.injectAccessibilityIdentifiers()
			return cell
		}
		
		return UITableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if sections[section] == SectionType.answer {
			return "QUESTION"
		} else if sections[section] == SectionType.question {
			return "ANSWERS"
		}
		return ""
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
}

class AnswerCell:UITableViewCell {
	@IBOutlet weak var actionLabel: UILabel!
}
