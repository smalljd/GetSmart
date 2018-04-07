//
//  QuestionDataSource.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

struct QuestionDataSource: TriviaDataSource {
    var questions: [Question]

    func correctAnswer(for question: Question) -> Answer? {
        return question.answers.filter { $0.isCorrect }.first
    }

    func numberOfQuestions() -> Int {
        return questions.count
    }

    func question(at index: Int) -> Question? {
        guard index >= 0, index < questions.count else {
            assertionFailure("Question index out of bounds: \(index)")
            return nil
        }

        return questions[index]
    }
}
