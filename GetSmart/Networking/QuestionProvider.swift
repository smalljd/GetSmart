//
//  QuestionProvider.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import Alamofire

typealias JSON = [String: Any]
typealias FetchQuestionsCompletion = (Result<[Question]>) -> Void

class QuestionProvider {
    let urlString = "https://opentdb.com/api.php?amount=3&category=18&difficulty=medium&type=multiple"
    func fetchQuestions(completionHandler: @escaping FetchQuestionsCompletion) {
        Alamofire.request(urlString).responseJSON(queue: DispatchQueue.main, options: .allowFragments) { [weak self] response in
            guard let `self` = self else {
                completionHandler(Result<[Question]>.failure(AFError.responseSerializationFailed(reason: .inputFileNil)))
                return
            }

            switch response.result {
            case .failure(let error):
                completionHandler(Result<[Question]>.failure(error))
            case .success(let result):
                if let json = result as? JSON {
                    completionHandler(self.mapQuestionOrError(from: json))
                } else {
                    completionHandler(
                        Result<[Question]>.failure(AFError.responseSerializationFailed(reason: .inputDataNil))
                    )
                }
            }
        }
    }

    func mapQuestionOrError(from result: JSON) -> Result<[Question]> {
        guard let questions = result["results"] as? [JSON] else {
            return .failure(AFError.responseSerializationFailed(reason: .stringSerializationFailed(encoding: .utf8)))
        }

        var results = [Question]()
        for question in questions {
            if let category = question["category"] as? String,
                let difficulty = question["difficulty"] as? String,
                let incorrectAnswers = question["incorrect_answers"] as? [String],
                let correctAnswer = question["correct_answer"] as? String,
                let prompt = question["question"] as? String {
                let sanitizedPrompt = sanitized(htmlString: prompt)
                let correctAnswerMapped = Answer(text: sanitized(htmlString: correctAnswer), isCorrect: true)
                let incorrectAnswersMapped = incorrectAnswers.map { Answer(text: sanitized(htmlString: $0), isCorrect: false) }

                let newQuestion = Question(
                    prompt: sanitizedPrompt, category: category,
                    difficulty: QuestionDifficulty(rawValue: difficulty) ?? .easy,
                    correctAnswer: correctAnswerMapped,
                    incorrectAnswers: incorrectAnswersMapped
                )

                results.append(newQuestion)
            } else {
                return .failure(AFError.responseSerializationFailed(reason: .stringSerializationFailed(encoding: .utf8)))
            }
        }

        return .success(results)
    }

    private func sanitized(htmlString: String) -> String {
        var sanitizedString = htmlString
        let stringReplacements: [String: String] = [
            "&nbsp;": " ",
            "&lt;": "<",
            "&gt;": ">",
            "&amp;": "&",
            "&quot;": "\"",
            "&apos;": "'",
            "&#039;": "'",
            "&copy;": "©",
            "&reg;": "®",
            "": "",
        ]

        for key in stringReplacements.keys {
            if sanitizedString.contains(key) {
                sanitizedString = sanitizedString.replacingOccurrences(of: key, with: stringReplacements[key] ?? "", options: .literal)
            }
        }

        return sanitizedString
    }
}
