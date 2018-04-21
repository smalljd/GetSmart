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

        numberCorrectLabel.text = String(describing: questionManager?.correctAnswersCount ?? 0)
        numberTotalLabel.text = String(describing: questionManager?.totalQuestions ?? 0)
    }

    @IBAction func didTapFinish(_ sender: Any) {
        dismiss(animated: true)
    }
}
