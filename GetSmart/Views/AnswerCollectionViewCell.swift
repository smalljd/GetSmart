//
//  AnswerCollectionViewCell.swift
//  GetSmart
//
//  Created by Jeff on 4/7/18.
//  Copyright © 2018 Jeff Small. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var answerLabel: UILabel!

    var answer: Answer?

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderColor = Colors.darkBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }

    func configure(from answer: Answer) {
        self.answer = answer
        answerLabel.text = answer.text
    }

    func select() {
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = Colors.darkBlue
        answerLabel.textColor = UIColor.white
    }

    func deselect() {
        layer.borderColor = Colors.darkBlue.cgColor
        backgroundColor = UIColor.white
        answerLabel.textColor = Colors.darkBlue
    }
}
