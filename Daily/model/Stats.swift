//
//  Stats.swift
//  Daily
//
//  Created by Nicolai Schneider on 25.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

struct Stats: Codable {
    var answer: Int!
    var dateOfAnswer: Date!
    
    init(ans: Int, date: Date) {
        self.answer = ans
        self.dateOfAnswer = date
    }
}
