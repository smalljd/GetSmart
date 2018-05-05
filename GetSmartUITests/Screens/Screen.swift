//
//  Screen.swift
//  GetSmartUITests
//
//  Created by Jeff on 5/3/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import XCTest

class Screen {
    var app = XCUIApplication()

    var identifier: String {
        assertionFailure("Should be implemented by subclasses.")
        return ""
    }
}
