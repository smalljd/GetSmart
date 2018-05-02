//
//  HomeViewController.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var questionProvider: QuestionProvider?
    @IBOutlet weak var startGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionProvider = QuestionProvider()
    }

    @IBAction func didTapStartGame(_ sender: Any) {
        questionProvider?.fetchQuestions { [weak self] result in
            guard let `self` = self else {
                return
            }

            switch result {
            case .success(let questions):
                let dataSource = QuestionDataSource(questions: questions)
                let questionManager = QuestionManager(dataSource: dataSource)
                self.navigateToQuestionViewController(manager: questionManager)
            case .failure(let error):
                let alertController = UIAlertController(title: "Whoops", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func navigateToQuestionViewController(manager: QuestionManager) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: QuestionViewController.self))
        guard let nextQuestionViewController = storyboard.instantiateViewController(withIdentifier: String(describing: QuestionViewController.self)) as? QuestionViewController else {
            assertionFailure("Could not locate the next question view controller.")
            return
        }

        nextQuestionViewController.questionManager = manager
        nextQuestionViewController.dismissalType = .dismiss
        let questionNavigationController = UINavigationController(rootViewController: nextQuestionViewController)
        present(questionNavigationController, animated: true)
    }
}

