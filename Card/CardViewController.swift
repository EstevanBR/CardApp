//
//  ViewController.swift
//  Card
//
//  Created by Estevan Hernandez on 12/20/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

import UIKit
import AVFoundation

class CardViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, CardDelegate, UIGestureRecognizerDelegate {
	var audioRecorder: AVAudioRecorder!
	var audioPlayer: AVAudioPlayer!
	var recordingSession: AVAudioSession! = AVAudioSession.sharedInstance()
	
	let questionSegue:String = "questionSegue"

	@IBOutlet var cardView: Card!
	//@IBOutlet var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		cardView.delegate = self
		cardView.layer.cornerRadius = 16.0
		//UIApplication.shared.delegate = self
		do {
			//try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
			try recordingSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: AVAudioSession.Mode.default)
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
			alert = UIAlertController(title: "Error!", message: "Failed to record", preferredStyle: UIAlertController.Style.alert)
			show(alert, sender: self)
		}
		
		
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		self.view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		UIView.animate(withDuration: 0.25, animations: {
			self.view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
		})
	}
	override func viewWillDisappear(_ animated: Bool) {
		UIView.animate(withDuration: 0.25, animations: {
			self.view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
		})
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
			cardView.recordButton.setTitle(ButtonTitles.stop, for: .normal)
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
			cardView.recordButton.setTitle(ButtonTitles.record, for: .normal)
		} else {
			cardView.recordButton.setTitle(ButtonTitles.record, for: .normal)
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
			cardView.playButton.setTitle(ButtonTitles.play, for: .normal)
		} else {
			cardView.playButton.setTitle(ButtonTitles.play, for: .normal)
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
			cardView.playButton.setTitle(ButtonTitles.stop, for: .normal)
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
		let alertVC = UIAlertController.init(title: "Audio Output", message: "Choose Audio Output Device", preferredStyle: .actionSheet)
		
		alertVC.addAction(UIAlertAction.init(title: "Default", style: .default, handler: { (action) in
			do {
				let session = AVAudioSession.sharedInstance()
				try session.overrideOutputAudioPort(.none)
				self.play(card: card)
			} catch let error {
				self.showError(message: error.localizedDescription)
			}
		}))
		alertVC.addAction(UIAlertAction.init(title: "Speaker", style: .default, handler: { (action) in
			do {
				let session = AVAudioSession.sharedInstance()
				try session.overrideOutputAudioPort(.speaker)
				self.play(card: card)
			} catch let error{
				self.showError(message: error.localizedDescription)
			}
		}))
		//show(alertVC, sender: self)
		present(alertVC, animated: false) {
			//<#code#>
		}
	}
	
	func showError(message: String) {
		let errorVC = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
		errorVC.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler:nil))
		show(errorVC, sender: self)
	}
	
	func play(card: Card) {
		if audioPlayer == nil {
			card.recordButton.isEnabled = false
			startPlaying(answerForQuestion: self.cardView.questionLabel.text!)
		} else {
			card.recordButton.isEnabled = true
			stopPlaying(success: true)
		}
	}
	
	func addTapped(card: Card) {
		let alert = UIAlertController(title: ButtonTitles.add, message: "", preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "?"
		}
		let okAction = UIAlertAction(title: ButtonTitles.checkmark, style: .default) { (action) in
			if let textFields = alert.textFields {
				if textFields.count > 0 {
					if let text = textFields[0].text {
						print("ok, adding: \(text)")
						card.questions.queue.insert(text, at: card.cardIndex)
						card.questions.masterList.append(text)
						card.setCardIndex(to: card.cardIndex)
						card.questions.archiveQuestions()
						//self.tableView.reloadData()
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
		//performSegue(withIdentifier: questionSegue, sender: self)
		dismiss(animated: true) {
			sharedQuestions.unarchiveQuestions()
		}
	}
	func markAsCompleteTapped(card: Card) {
		//self.tableView.reloadData()
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
	
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
	@IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
		if sender.direction == .down {
			dismiss(animated: true, completion: nil)
		}
	}
	
	
	
	//MARK: QuestionCellDelegate
//	func playTapped(questionCell: QuestionCell) {
//		self.startPlaying(answerForQuestion: questionCell.questionLabel.text!)
//	}
}




// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
