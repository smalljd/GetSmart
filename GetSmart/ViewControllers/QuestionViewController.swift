//
//  QuestionViewController.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import UIKit

enum DismissalType {
    case dismiss
    case pop
}

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var answerCollectionView: UICollectionView!
    @IBOutlet weak var questionTextView: UITextView!

    var answers = [Answer]()
    var cells = [Int: AnswerCollectionViewCell]()
    var dismissalType: DismissalType = .pop
    var question: Question?
    var questionManager: QuestionManager?
    var selectedAnswer: Answer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView(answerCollectionView)
    }

    func configureCollectionView(_ collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        answerCollectionView.collectionViewLayout = layout
        answerCollectionView.dataSource = self
        answerCollectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let questionManager = questionManager else {
            assertionFailure("Question should not be nil.")
            return
        }

        let currentQuestion = questionManager.dataSource?.question(at: questionManager.currentIndex)
        question = currentQuestion
        answers = currentQuestion?.answers.shuffled() ?? []
        navigationItem.title = currentQuestion?.prompt
        questionTextView.text = currentQuestion?.prompt ?? ""
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        title = "Question \((questionManager?.currentIndex ?? 0) + 1)"
        configureDismissalButton(for: dismissalType)
    }

    private func configureDismissalButton(for type: DismissalType) {
        switch type {
        case .dismiss:
            let dismissalButton = UIBarButtonItem(title: "Quit", style: .plain, target: self, action: #selector(dismissQuestions))
            navigationItem.setLeftBarButton(dismissalButton, animated: false)
        case .pop:
            let previousButton = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(didTapPreviousQuestion(_:)))
            navigationItem.setLeftBarButton(previousButton, animated: false)
        }
    }

    @objc
    private func dismissQuestions() {
        navigationController?.dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 14
        let collectionViewWidth = collectionView.frame.width - padding
        return CGSize(width: collectionViewWidth / 2, height: 100)
    }

    @IBAction func didTapNextQuestion(_ sender: Any) {
        guard let answer = selectedAnswer else {
            let alertController = UIAlertController(title: "Forget Something?", message: "Please select an answer before proceding to the next question.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Got it", style: .default, handler: nil)
            alertController.addAction(okAction)

            present(alertController, animated: true)
            return
        }

        guard let questionManager = questionManager, let question = question else {
            assertionFailure("Something went wrong.")
            return
        }

        questionManager.answerQuestion(question, answer: answer)
        let finalIndex = (questionManager.dataSource?.numberOfQuestions() ?? 0)
        if questionManager.currentIndex >= finalIndex {
            navigateToResults()
        } else {
            navigateToNextQuestion()
        }
    }

    @IBAction func didTapPreviousQuestion(_ sender: Any) {
        questionManager?.goToPreviousQuestion()
        navigationController?.popViewController(animated: true)
    }

    func navigateToNextQuestion() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: QuestionViewController.self))
        guard let nextQuestionViewController = storyboard.instantiateViewController(withIdentifier: String(describing: QuestionViewController.self)) as? QuestionViewController else {
            assertionFailure("Could not locate the next question view controller.")
            return
        }

        nextQuestionViewController.questionManager = questionManager
        navigationController?.pushViewController(nextQuestionViewController, animated: true)
    }

    func navigateToResults() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: GameResultsViewController.self))
        guard let resultsViewController = storyboard.instantiateViewController(withIdentifier: String(describing: GameResultsViewController.self)) as? GameResultsViewController else {
            assertionFailure("Could not locate the game results view controller.")
            return
        }

        resultsViewController.questionManager = questionManager
        navigationController?.pushViewController(resultsViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AnswerCollectionViewCell.self), for: indexPath) as? AnswerCollectionViewCell,
            index < answers.count else {
            assertionFailure("Could not dequeue reusable cell with identifier \(String(describing: AnswerCollectionViewCell.self))")
            return UICollectionViewCell()
        }

        cell.configure(from: answers[index])
        cells[index] = cell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for cellIndex in 0 ..< cells.count {
            if cellIndex == indexPath.item {
                cells[cellIndex]?.select()
                selectedAnswer = answers[cellIndex]
            } else {
                cells[cellIndex]?.deselect()
            }
        }
    }
}
