//
//  StatsComputer.swift
//  Daily
//
//  Created by Nicolai Schneider on 24.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

class StatsComputer: NSObject {
    
    override init() {
        super.init()
    }
    
    static func avgStatsForYesNoQuestion (question: Question) -> (Float,Float)? {
        if question.timesAnswered == 0 { return nil }
        
        let yesScore: Float = (Float(question.stats[0]) / Float(question.timesAnswered)) * 100
        let noScore: Float = (Float(question.stats[1]) / Float(question.timesAnswered)) * 100
        return (yesScore, noScore)
    }
    
    static func avgStatsForScale1to5Question (question: Question) -> Float? {
        if question.timesAnswered == 0 { return nil }
        
        var score: Float = 0
        for i in 0..<question.stats.count {
            score += Float(i+1) * Float(question.stats[i])
        }
        score = score / Float(question.timesAnswered)
        return score
    }
    
}
