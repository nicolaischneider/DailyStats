//
//  Stats.swift
//  Daily
//
//  Created by Nicolai Schneider on 01.03.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

struct Stats: Codable {
    var answers: [Int]!
    var selectedBehaviors: [[UUID:Int]]!
    
    init(possibleAnswers: Int) {
        self.answers = [Int]()
        self.selectedBehaviors = [[UUID:Int]]()
        
        for _ in 0..<possibleAnswers {
            self.answers.append(0)
            self.selectedBehaviors.append([UUID:Int]())
        }
    }
    
    mutating func updateStats (answer: Int, behaviors: [Behavior]) {
        // increment value of answer
        self.answers[answer] += 1
        
        // increment behavior appearance
        for behavior in behaviors {
            if let id = behavior.id {
                if let val = self.selectedBehaviors[answer][id] {
                    self.selectedBehaviors[answer][id] = val+1
                } else {
                    self.selectedBehaviors[answer][id] = 1
                }
            }
        }
    }
}
