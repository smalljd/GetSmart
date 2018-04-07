//
//  Question.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

struct Question {
    let question: String
    let answers: [Answer]

    init(question: String, answers: String...) {
        var tempAnswers = [Answer]()
        answers.forEach { answer in
            tempAnswers.append(Answer(text: answer, isCorrect: false, isSelected: false))
        }

        self.question = question
        self.answers = tempAnswers
    }
}
