//
//  QuestionViewController.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var answerCollectionView: UICollectionView!
    @IBOutlet weak var questionTextView: UITextView!

    var question: Question?
    var answers = [Answer]()
    var selectedAnswer: Answer?

    var cells = [Int: AnswerCollectionViewCell]()

    var questionManager: QuestionManager?

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
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 14
        let collectionViewWidth = collectionView.frame.width - padding
        return CGSize(width: collectionViewWidth / 2, height: 100)
    }

    @IBAction func didTapNextQuestion(_ sender: Any) {
        guard let questionManager = questionManager, let question = question, let answer = selectedAnswer else {
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
