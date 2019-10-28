//
//  UIView+Card.swift
//  Card
//
//  Created by Estevan Hernandez on 10/24/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import Foundation
import UIKit
import os.log

extension OSLog {
	private static var subsystem = Bundle.main.bundleIdentifier!
	static let aaid = OSLog(subsystem: subsystem, category: "aaid")
}

protocol AccessibilityIdentifierInjector {
	func injectAccessibilityIdentifiers()
}

extension AccessibilityIdentifierInjector {
	func injectAccessibilityIdentifiers() {
		var mirror: Mirror? = Mirror(reflecting: self)
		repeat {
			if let mirror = mirror {
				injectOn(mirror: mirror)
			}
			mirror = mirror?.superclassMirror
		} while (mirror != nil)
	}

	private func injectOn(mirror: Mirror) {
		for (name, value) in mirror.children {
			if var value = value as? UIView {
				let accessibilityIdentifier:String = "\(String(describing: mirror.subjectType.self)).\(name ?? "UNKNOWN")"
				UnsafeMutablePointer(&value)
					.pointee
					.accessibilityIdentifier = accessibilityIdentifier
				os_log(.default, log: .aaid, "%s", accessibilityIdentifier)
			}
		}
	}
}

extension UIViewController: AccessibilityIdentifierInjector {}
extension UIView: AccessibilityIdentifierInjector {}
