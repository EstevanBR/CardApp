//
//  ViewController.swift
//  Card
//
//  Created by Estevan Hernandez on 12/20/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, CardDelegate {
	var audioRecorder: AVAudioRecorder!// = AVAudioRecorder()
	var audioPlayer: AVAudioPlayer!// = AVAudioPlayer()
	var recordingSession: AVAudioSession! = AVAudioSession.sharedInstance()

	@IBOutlet var cardView: Card!
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
	
	func startRecording(index cardIndex: Int) {
		let audioFilename = getDocumentsDirectory().appendingPathComponent("rec_\(String(cardIndex)).m4a")
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
			cardView.recordButton.setTitle("Tap to Stop", for: .normal)
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
			cardView.recordButton.setTitle("Tap to Re-record", for: .normal)
		} else {
			cardView.recordButton.setTitle("Tap to Record", for: .normal)
			// recording failed :(
		}
	}
	
	func stopPlaying(success: Bool) {
		if audioPlayer != nil {
			audioPlayer.stop()
			audioPlayer = nil
		}
		
		if success {
			cardView.playButton.setTitle("Tap to Play", for: .normal)
		} else {
			cardView.playButton.setTitle("Tap to Try Again", for: .normal)
		}
	}
	
	func startPlaying(index cardIndex: Int) {
		let audioFilename = getDocumentsDirectory().appendingPathComponent("rec_\(String(cardIndex)).m4a")
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
			audioPlayer.delegate = self
			audioPlayer.setVolume(1.0, fadeDuration: 0)
			audioPlayer.play()
			cardView.playButton.setTitle("Stop", for: .normal)
		} catch {
			stopPlaying(success: false)
		}
		
	}
	// MARK: CardDelegate
	func recordTapped(card: Card) {
		if audioRecorder == nil {
			startRecording(index: card.cardIndex)
		} else {
			finishRecording(success: true)
		}
	}
	
	func playTapped(card: Card) {
		if audioPlayer == nil {
			startPlaying(index: card.cardIndex)
		} else {
			stopPlaying(success: true)
		}
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
}

