//
//  QuestionManager.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

class QuestionManager {
    var questionAnswerLog = [Question: Answer]()
    var correctAnswersCount = 0
    var currentIndex = 0
    var dataSource: TriviaDataSource?

    lazy var totalQuestions: Int = {
        return dataSource?.numberOfQuestions() ?? 0
    }()

    init() {}

    convenience init(dataSource: TriviaDataSource) {
        self.init()
        self.dataSource = dataSource

        for index in 0 ..< dataSource.numberOfQuestions() {
            if let question = dataSource.question(at: index) {
                questionAnswerLog[question] = nil
            }
        }
    }

    func answerQuestion(_ question: Question, answer: Answer) {
        questionAnswerLog[question] = answer
        currentIndex += 1
    }

    func goToPreviousQuestion() {
        currentIndex -= 1
    }
}
