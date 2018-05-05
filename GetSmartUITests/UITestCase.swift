//
//  UITestCase.swift
//  GetSmartUITests
//
//  Created by Jeff on 5/3/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import XCTest

class UITestCase: XCTestCase {
    var app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    /// Wait for an expected combination of XCUIElements and their identifier, so that we
    /// can determine with certainty whether we're on a particular screen.
    ///
    /// - Parameters:
    ///   - identifier: The accessibility identifier, accessibility label, or user facing text that the test is expecting.
    ///   - elementType: The type of element to look for (e.g. `XCUIApplication().collectionViews`)
    ///   - timeout: The number of seconds to wait before determining a failure.
    /// - Returns: True if the expected element exists within the timeout period, false otherwise.
    func waitForScreen(withIdentifier identifier: String,
                       elementType: XCUIElementQuery,
                       timeout: TimeInterval = 5) -> Bool {
        return elementType[identifier].waitForExistence(timeout: timeout)
    }

    /// By default we will look at the navigation bar title with a 5 second timeout.
    func waitForScreen(withIdentifier identifier: String, timeout: TimeInterval = 5) -> Bool {
        return waitForScreen(withIdentifier: identifier, elementType: app.navigationBars, timeout: timeout)
    }
}
