//
//  QuestionScreen.swift
//  GetSmartUITests
//
//  Created by Jeff on 5/3/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import XCTest

class QuestionScreen: Screen {
    override var identifier: String {
        return AccessibilityIdentifier.answerCollectionView
    }

    var collectionView: XCUIElement {
        return app.collectionViews[AccessibilityIdentifier.answerCollectionView].firstMatch
    }

    var nextQuestionButton: XCUIElement {
        return app.buttons[AccessibilityIdentifier.nextQuestionButton].firstMatch
    }

    func selectAnswerAndGoToNext() {
        collectionView.cells.firstMatch.tap()
        nextQuestionButton.tap()
    }
}
