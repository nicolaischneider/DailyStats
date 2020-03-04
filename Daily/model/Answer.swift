//
//  Answer.swift
//  Daily
//
//  Created by Nicolai Schneider on 01.03.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

struct Answer: Codable {
    var answer: Int!
    var dateOfAnswer: Date!
    var behaviors: [Behavior]!
    
    init(ans: Int, date: Date, behaviors: [Behavior]) {
        self.answer = ans
        self.dateOfAnswer = date
        self.behaviors = behaviors
    }
}
