//
//  GameResultsViewController.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import UIKit

class GameResultsViewController: UIViewController {

    @IBOutlet weak var numberCorrectLabel: UILabel!
    @IBOutlet weak var numberTotalLabel: UILabel!
    var questionManager: QuestionManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let questionManager = questionManager else {
            assertionFailure("Question Manager should not be nil.")
            return
        }

        let numberOfQuestions = questionManager.questionAnswerLog.keys.count
        let numberOfCorrectAnswers = questionManager
            .questionAnswerLog
            .values
            .filter { $0.isCorrect }
            .count

        numberCorrectLabel.text = String(describing: numberOfCorrectAnswers)
        numberTotalLabel.text = String(describing: numberOfQuestions)
    }

    @IBAction func didTapFinish(_ sender: Any) {
        dismiss(animated: true)
    }
}
