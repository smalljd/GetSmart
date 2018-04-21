//
//  Array+GetSmart.swift
//  GetSmart
//
//  Created by Jeff on 4/21/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import Foundation

extension Array where Element == Answer {
    func shuffled() -> [Element] {
        if count < 2 { return self }

        var shuffledResults = self

        for index in 0 ..< shuffledResults.count - 1 {
            let randomIndex = Int(arc4random_uniform(UInt32(count - index))) + index
            shuffledResults.swapAt(index, randomIndex)
        }

        for answer in shuffledResults where answer.isCorrect {
            print("Correct answer: \(answer)")
        }

        return shuffledResults
    }
}
