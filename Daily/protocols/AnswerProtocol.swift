//
//  File.swift
//  Daily
//
//  Created by Nicolai Schneider on 12.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

protocol AnswerDelegate {
    func scale1to5QuestionWasAnsweredWith (res: Int, tag: Int)
    func yesQuestionWasAnsweredWithYes (res: Bool, tag: Int)
    func addBehaviors (selectedBehaviors: [Bool])
}
