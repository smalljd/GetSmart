//
//  TriviaDataSource.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import Foundation

protocol TriviaDataSource {
    func correctAnswer(for question: Question) -> Answer?
    func numberOfQuestions() -> Int
    func question(at index: Int) -> Question?
}
