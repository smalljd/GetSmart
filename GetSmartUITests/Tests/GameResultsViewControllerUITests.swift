//
//  GameResultsViewControllerUITests.swift
//  GetSmartUITests
//
//  Created by Jeff on 5/3/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import XCTest

class GameResultsViewControllerUITests: UITestCase {
    override func setUp() {
        super.setUp()

        // Before each test, let's navigate to the "Game Results" view controller.
        startGame()
        answerEachQuestionAndTapNext()
    }

    func testTappingFinishButton() {
        GameResultsScreen().finishButton.tap()
        XCTAssertTrue(waitForScreen(withIdentifier: WelcomeScreen().identifier),
                      "Expected to land on the Home screen after tapping 'Finish'")
    }

    // MARK: Private Methods

    private func startGame() {
        let welcomeScreen = WelcomeScreen()
        XCTAssertTrue(waitForScreen(withIdentifier: welcomeScreen.identifier), "We are not on the Welcome screen.")

        welcomeScreen.startGameButton.tap()
    }

    private func answerEachQuestionAndTapNext() {
        let questionScreen = QuestionScreen()

        // As long an we are on the question screen, continue selecting answers and tapping "Next".
        while waitForScreen(withIdentifier: questionScreen.identifier, elementType: app.collectionViews, timeout: 1) {
            questionScreen.selectAnswerAndGoToNext()
        }

        XCTAssertTrue(waitForScreen(withIdentifier: GameResultsScreen().identifier), "We are not on the game results screen.")
    }
}
