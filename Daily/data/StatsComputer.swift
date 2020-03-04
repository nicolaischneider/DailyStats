//
//  StatsComputer.swift
//  Daily
//
//  Created by Nicolai Schneider on 24.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

class StatsComputer: NSObject {
    
    var delegate: BehaviorDelegate!
    
    let maxNumOfBehaviors = 2 // max number of behaviors / answer
    let minNumOfNeededAppearances = 10 // needed appearance of behavior to be added to answer
    
    override init() {
        super.init()
    }
    
    private func getBehaviorFromID (id: UUID) -> Behavior? {
        let list = delegate.getListOfBehaviors()
        for behavior in list {
            if id == behavior.id {
                return behavior
            }
        }
        // error behavior not found
        return nil
    }
    
    func getAvgStatsForQuestion (question: Question) -> [Float]? {
        if question.timesAnswered == 0 { return nil }
        
        var listOfPercentages = [Float]()
        
        // go thorugh all possible answers (e.g. yes/no has two) and compute their percentage
        for answer in question.stats.answers {
            let answerPercentage = (Float(answer) / Float(question.timesAnswered)) * 100
            listOfPercentages.append(answerPercentage)
        }
        return listOfPercentages
    }
    
    func getAvgScoreForQuestion (question: Question) -> Float? {
        if question.timesAnswered == 0 { return nil }
        
        var totalScore = 0
        for i in 0..<question.stats.answers.count {
            totalScore += (i+1) * question.stats.answers[i]
        }
        
        let avgScore: Float = Float(totalScore) / Float(question.timesAnswered)
        return avgScore
    }
    
    func getMostUsedBehaviorsForQuestion (question: Question) -> [[Behavior?]]? {
        if question.timesAnswered == 0 { return nil }
        
        var listOfbehaviors = [[Behavior?]]()
            
        for answer in question.stats.selectedBehaviors {
            var answerList = [(UUID,Int)]() // behavior id and appearances
            for behavior in answer {
                
                // check if behavior still exists
                guard let _ = getBehaviorFromID(id: behavior.key) else {
                    continue
                }
                
                // add element to list and sort list
                answerList.append((behavior.key, behavior.value))
                answerList = answerList.sorted(by: {$0.1 < $1.1})
                
                // in case behavior number exeeds max number
                if answerList.count > maxNumOfBehaviors {
                    answerList.remove(at: 0)
                }
            }
            
            // add actual behaviors to list IFF they meet the minimum appearance requirement
            var listOfbehaviorsForAnswer = [Behavior?]()
            for _behavior in answerList {
                // check for min number of appearances
                if _behavior.1 < minNumOfNeededAppearances {
                    listOfbehaviorsForAnswer.append(nil)
                    continue
                }
                
                if let __behavior = getBehaviorFromID(id: _behavior.0) {
                    listOfbehaviorsForAnswer.append(__behavior)
                }
            }
            
            // add to main list
            listOfbehaviors.append(listOfbehaviorsForAnswer)
        }
        
        // return nil for empty list
        if listOfbehaviors.count == 0 { return nil }
        else { return listOfbehaviors }
    }
}
