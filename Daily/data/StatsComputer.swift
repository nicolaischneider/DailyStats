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
    
    // MARK: - yes/no questions
    // all time
    static func avgStatsForYesNoQuestion (question: Question) -> (Float,Float)? {
        // break in case the question has never been answered before
        if question.timesAnswered == 0 { return nil }
        
        var yesScore: Float = 0
        var noScore: Float = 0
        
        for  i in 0..<question.stats.count {
            let stat = question.stats[i]
            // 0: yes, 1: no
            if stat.answer == 0 { yesScore += 1 }
            else { noScore += 1 }
        }
        yesScore = (yesScore / Float(question.timesAnswered)) * 100
        noScore = (noScore / Float(question.timesAnswered)) * 100
        
        return (yesScore, noScore)
    }
    
    // last week
    /*static func statsLastWeekYesNoQuestion (question: Question) -> (Float,Float) {
        
    }
    
    // last month
    static func statsLastMonthYesNoQuestion (question: Question) -> (Float,Float) {
        
    }*/
    
    // MARK: - scale 1-5 questions
    // all time
    static func avgStatsForScale1to5Question (question: Question) -> Float? {
        if question.timesAnswered == 0 { return nil }
        
        var score: Float = 0
        for i in 0..<question.stats.count {
            let stat = question.stats[i]
            score += Float(stat.answer+1)
        }
        score = score / Float(question.timesAnswered)
        return score
    }
    
}
