//
//  WelcomeScreen.swift
//  GetSmartUITests
//
//  Created by Jeff on 5/3/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import XCTest

class WelcomeScreen: Screen {
    override var identifier: String {
        return "Welcome"
    }

    var startGameButton: XCUIElement {
        return app.buttons[AccessibilityIdentifier.startGameButton].firstMatch
    }
    var headerStackView: XCUIElement {
        return app.otherElements[AccessibilityIdentifier.welcomeHeaderStackView].firstMatch
    }
    var messageLabel: XCUIElement {
        return app.staticTexts[AccessibilityIdentifier.welcomeMessageLabel].firstMatch
    }
}
