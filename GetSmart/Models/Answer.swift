//
//  Answer.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

struct Answer: Codable, CustomDebugStringConvertible {
    var debugDescription: String

    let text: String
    var isCorrect: Bool

    init(text: String, isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect

        debugDescription = "\(text): \(isCorrect ? "true" : "false")"
    }

    init(text: String) {
        self.init(text: text, isCorrect: false)
    }
}
