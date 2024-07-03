//
//  WrongAnswerCell.swift
//  EssDevQuiz
//
//  Created by admin on 03.07.2024.
//

import UIKit

class WrongAnswerCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var wrongAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    static let identifier = "WrongAnswerCell"
}
