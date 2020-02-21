//
//  Question.swift
//  Daily
//
//  Created by Nicolai Schneider on 26.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    var tag: UUID!
    var question: String!
    var type: QuestionType!
    var color: UIColor!
    var timesAnswered: Int!
    var dateOfCreation: Date!
    var lastAnswered: Date?
    var stats: [Int]!
    
    init(question: String, type: QuestionType, color: UIColor) {
        self.tag = UUID()
        self.question = question
        self.type = type
        self.color = color
        self.timesAnswered = 0
        self.dateOfCreation = Date(timeIntervalSinceNow: 0)
        
        // get stats array ready
        switch type.getType() {
            case .yesNo: self.stats = [0,0]
            case .scale1to5: self.stats = [0,0,0,0,0]
        }
    }
}
