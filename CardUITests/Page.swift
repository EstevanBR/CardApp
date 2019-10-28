//
//  Page.swift
//  CardUITests
//
//  Created by Estevan Hernandez on 10/27/19.
//  Copyright © 2019 Estevan Hernandez. All rights reserved.
//

import XCTest

protocol Page {
	var app: XCUIApplication { get }
	var root:String { get }
	var element:XCUIElement { get }
}

extension Page {
	var app:XCUIApplication {
		return XCUIApplication()
	}
	
	var element: XCUIElement {
		return app.otherElements[root]
	}
	
	func wait(for duration: TimeInterval, before: ()->Void, after: ()->Void) -> Page {
		_ = wait(for: duration, before: before)
		after()
		return self
	}
	func wait(for duration: TimeInterval, before: ()->Void) -> Page {
		app.tap()
		before()
		RunLoop.current.run(until: Date.init(timeIntervalSinceNow: duration))
		return self
	}
	
	func test(block: ()->Bool) -> Void {
		XCTAssert(block())
	}
	
	func tap(buttonWithAccessibilityIdentifier accessibilityIdentifier:String) {
		_ = app.buttons[accessibilityIdentifier].waitForExistence(timeout: 0.5)
		app.buttons[accessibilityIdentifier].tap()
	}
	func tap(cellWithAccessibilityIdentifier accessibilityIdentifier:String) {
		_ = app.tables.cells[accessibilityIdentifier].waitForExistence(timeout: 0.5)
		app.tables.cells[accessibilityIdentifier].tap()
	}
}
