//
//  Question.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import Foundation

enum QuestionDifficulty: String, Codable {
    case easy
    case medium
    case hard
}

struct Question: Codable, CustomDebugStringConvertible, Equatable, Hashable {
    var debugDescription: String
    var hashValue: Int

    let prompt: String
    let category: String
    let difficulty: QuestionDifficulty
    private let correctAnswer: Answer
    private let incorrectAnswers: [Answer]

    enum CodingKeys: String, CodingKey {
        case category
        case correctAnswer = "correct_answer"
        case difficulty
        case incorrectAnswers = "incorrect_answers"
        case prompt = "question"
    }

    init(prompt: String,
         category: String,
         difficulty: QuestionDifficulty,
         correctAnswer: Answer,
         incorrectAnswers: [Answer]) {
        self.prompt = prompt
        self.category = category
        self.difficulty = difficulty
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers

        hashValue = prompt.hashValue
        debugDescription = "\n" + prompt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.prompt = try container.decode(String.self, forKey: .prompt)
        self.category = try container.decode(String.self, forKey: .category)
        self.incorrectAnswers = try container.decode([Answer].self, forKey: .incorrectAnswers)
        self.correctAnswer = try container.decode(Answer.self, forKey: .correctAnswer)
        self.difficulty = try container.decode(QuestionDifficulty.self, forKey: .difficulty)
        self.hashValue = self.prompt.hashValue
        self.debugDescription = "\n" + prompt
    }

    var answers: [Answer] {
        return [correctAnswer] + incorrectAnswers
    }

    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.prompt == rhs.prompt
    }
}
