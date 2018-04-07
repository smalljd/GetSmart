//
//  QuestionManager.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

class QuestionManager {
    var dataSource: TriviaDataSource?
    var correctAnswersCount = 0

    lazy var totalQuestions: Int = {
        return dataSource?.numberOfQuestions() ?? 0
    }()

    init() {}

    convenience init(dataSource: TriviaDataSource) {
        self.init()
        self.dataSource = dataSource
    }

    func answerQuestion(_ question: Question, answer: Answer) {
        guard let dataSource = dataSource, answer.text == dataSource.correctAnswer(for: question)?.text else {
            return
        }

        correctAnswersCount += 1
    }
}
