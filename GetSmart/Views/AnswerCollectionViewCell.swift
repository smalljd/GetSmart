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

    override func awakeFromNib() {
        layer.cornerRadius = 5
        layer.borderColor = Colors.darkBlue.cgColor
    }

    func configure(from answer: Answer) {
        answerLabel.text = answer.text
        layer.borderColor = answer.isSelected ? UIColor.white.cgColor : Colors.darkBlue.cgColor
        backgroundColor = answer.isSelected ? Colors.darkBlue : UIColor.white
    }
}
