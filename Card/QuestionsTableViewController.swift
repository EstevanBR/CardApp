//
//  QuestionsTableViewController.swift
//  Card
//
//  Created by Estevan Hernandez on 8/30/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import Foundation
import UIKit

class QuestionsTableViewController: UITableViewController, QuestionCellDelegate {
	
	let questions:Questions = sharedQuestions
	let questionCell = "questionCell"
	let answerCell = "answerCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		questions.register(callBack: questionsUnarchived)
		questions.register(callBack: questionsArchived)
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
			let questionCell:QuestionCell = (tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionCell)!
			questionCell.questionLabel.text = questions.done[indexPath.row]
			questionCell.delegate = self
			return questionCell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: answerCell, for: indexPath)
			cell.accessibilityIdentifier = answerCell
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
	
	func queueEmpty() {
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
	override func awakeFromNib() {
		super.awakeFromNib()
		accessibilityIdentifier = AccessibilityIDs.questionCell
		isAccessibilityElement = false
		accessibilityElements = [questionLabel, playButton]
	}
}
protocol QuestionCellDelegate {
	func playTapped(questionCell: QuestionCell)
}
