//
//  ViewController.swift
//  Card
//
//  Created by Estevan Hernandez on 12/20/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, CardDelegate, UITableViewDelegate, UITableViewDataSource, QuestionCellDelegate {
	var audioRecorder: AVAudioRecorder!// = AVAudioRecorder()
	var audioPlayer: AVAudioPlayer!// = AVAudioPlayer()
	var recordingSession: AVAudioSession! = AVAudioSession.sharedInstance()

	@IBOutlet var cardView: Card!
	@IBOutlet var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		cardView.delegate = self
		//UIApplication.shared.delegate = self
		do {
			//try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
			try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
			try recordingSession.setActive(true)
			recordingSession.requestRecordPermission() { [unowned self] allowed in
				DispatchQueue.main.async {
					if allowed {
						//self.loadRecordingUI()
						print("good stuff! \(self)")
					} else {
						// failed to record!
						print("bad stuff! \(self)")
					}
				}
			}
		} catch {
			// failed to record!
			var alert: UIAlertController!
			alert = UIAlertController(title: "Error!", message: "Failed to record", preferredStyle: UIAlertControllerStyle.alert)
			show(alert, sender: self)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func startRecording() {
		//let audioFilename = getDocumentsDirectory().appendingPathComponent("rec_\(String(cardIndex)).m4a")
		let audioFilename = getDocumentsDirectory().appendingPathComponent("rec_\(cardView.questions.absoluteIndex(forCardText: cardView.questions.queue[cardView.cardIndex])).m4a")
		let settings = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 12000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		
		do {
			audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
			audioRecorder.delegate = self
			audioRecorder.record()
			cardView.recordButton.setTitle("☐", for: .normal)
		} catch {
			finishRecording(success: false)
		}
	}
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
	func finishRecording(success: Bool) {
		audioRecorder.stop()
		audioRecorder = nil
		
		if success {
			cardView.recordButton.setTitle("⃝", for: .normal)
		} else {
			cardView.recordButton.setTitle("⃝", for: .normal)
			// recording failed :(
		}
		cardView.playButton.isEnabled = true
	}
	
	func stopPlaying(success: Bool) {
		if audioPlayer != nil {
			audioPlayer.stop()
			audioPlayer = nil
		}
		
		if success {
			cardView.playButton.setTitle("▷", for: .normal)
		} else {
			cardView.playButton.setTitle("▷", for: .normal)
		}
		cardView.recordButton.isEnabled = true
	}
	
	func startPlaying(answerForQuestion text: String) {
		//let audioFilename = getDocumentsDirectory().appendingPathComponent("rec_\(String(cardIndex)).m4a")
		let audioFilename = getDocumentsDirectory().appendingPathComponent("rec_\(cardView.questions.absoluteIndex(forCardText: text)).m4a")
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
			audioPlayer.delegate = self
			audioPlayer.setVolume(1.0, fadeDuration: 0)
			audioPlayer.play()
			cardView.playButton.setTitle("☐", for: .normal)
		} catch {
			stopPlaying(success: false)
		}
		
	}
	// MARK: CardDelegate
	func recordTapped(card: Card) {
		if audioRecorder == nil {
			card.playButton.isEnabled = false
			startRecording()
		} else {
			card.playButton.isEnabled = true
			finishRecording(success: true)
		}
	}
	
	func playTapped(card: Card) {
		if audioPlayer == nil {
			card.recordButton.isEnabled = false
			startPlaying(answerForQuestion: self.cardView.questionLabel.text!)
		} else {
			card.recordButton.isEnabled = true
			stopPlaying(success: true)
		}
	}
	
	func addTapped(card: Card) {
		print("")
		let alert = UIAlertController(title: "+", message: "", preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "?"
		}
		let okAction = UIAlertAction(title: "✓", style: .default) { (action) in
			if let textFields = alert.textFields {
				if textFields.count > 0 {
					if let text = textFields[0].text {
						print("ok, adding: \(text)")
						card.questions.queue.insert(text, at: card.cardIndex)
						card.questions.masterList.append(text)
						card.setCardIndex(to: card.cardIndex)
						card.questions.archiveQuestions()
						self.tableView.reloadData()
					}
				}
			}
		}
		let noAction = UIAlertAction(title: "ⅹ", style: .cancel) { (action) in
			print("no")
		}
		
		alert.addAction(noAction)
		alert.addAction(okAction)
		
		present(alert, animated: true) {
			print("presented")
		}
	}
	func historyTapped(card: Card) {
		print("history tapped")
		if self.view.subviews.contains(self.tableView) {
			self.tableView.removeFromSuperview()
			self.cardView.historyButton?.setTitle("⌛︎", for: .normal)
		} else {
			self.view.addSubview(self.tableView)
			self.tableView.frame = CGRect(x: 16, y: 30+16+8, width: self.view.frame.size.width-32, height: self.view.frame.size.height-(30+32+8))
			self.cardView.historyButton?.setTitle("ⅹ", for: .normal)
		}
	}
	func markAsCompleteTapped(card: Card) {
		self.tableView.reloadData()
	}
	// MARK: AVAudioRecorderDelegate
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if !flag {
			finishRecording(success: false)
		}
	}
	// MARK: AVAudioPlayerDelegate
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		if !flag {
			stopPlaying(success: false)
		} else {
			stopPlaying(success: true)
		}
	}
	// MARK: UITableViewDelegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.cardView.questions.done.count
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let questionCell:QuestionCell = (tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionCell)!
		questionCell.questionLabel.text = self.cardView.questions.done[indexPath.row]
		questionCell.delegate = self
		return questionCell
	}
	//MARK: QuestionCellDelegate
	func playTapped(questionCell: QuestionCell) {
		self.startPlaying(answerForQuestion: questionCell.questionLabel.text!)
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
protocol QuestionCellDelegate {
	func playTapped(questionCell: QuestionCell)
}

