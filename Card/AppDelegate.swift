//
//  AppDelegate.swift
//  Card
//
//  Created by Estevan Hernandez on 12/20/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//
import os
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		if ProcessInfo.processInfo.isReset {
			Questions.shared.done = []
			Questions.shared.queue = Questions.questionList()
			Questions.shared.archiveQuestions()
		}
		return true
	}
}

extension ProcessInfo {
	var isReset: Bool {
		os_log(.default, log: .default, "%s", "ProcessInfo.isReset")
		return arguments.contains(TestLaunchArguments.reset.rawValue)
	}
}
