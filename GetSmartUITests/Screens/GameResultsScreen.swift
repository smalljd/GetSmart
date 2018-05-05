//
//  GameResultsScreen.swift
//  GetSmartUITests
//
//  Created by Jeff on 5/3/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import XCTest

class GameResultsScreen: Screen {
    override var identifier: String {
        return "Your Score"
    }

    var finishButton: XCUIElement {
        return app.buttons[AccessibilityIdentifier.finishButton].firstMatch
    }
}
