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
    let minNumOfNeededAppearances = 2 // needed appearance of behavior to be added to answer
    
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
    
    // MARK: - average stats for question
    private func getListOfPercentagesFor (_ answerList: [Int], timesAnswered: Int) -> [Float] {
        
        var listOfPercentages = [Float]()
        
        if timesAnswered == 0 {
            for _ in answerList { listOfPercentages.append(0) }
            return listOfPercentages
        }
        
        // go thorugh all possible answers (e.g. yes/no has two) and compute their percentage
        for answer in answerList {
            let answerPercentage = (Float(answer) / Float(timesAnswered)) * 100
            listOfPercentages.append(answerPercentage)
        }
        
        return listOfPercentages
    }
    
    func getAvgStatsForQuestion (question: Question) -> [Float] {
        return getListOfPercentagesFor(question.stats.answers, timesAnswered: question.timesAnswered)
    }
    
    func getAvgStatsForQuestionForTime (question: Question, time: TimeInterval) -> [Float]? {
        // COMPUTE AN ARRAY [Int] EQUIVALENT TO question.stats.answers
        var answers = [Int]()
        for _ in question.stats.answers { answers.append(0) }
        var timesAnswered = 0
                
        for answer in question.answers.reversed() {
            // answer was given outside of time interval
            if answer.dateOfAnswer.timeIntervalSince(Date()-time) < 0 {
                break
            }
            answers[answer.answer] += 1
            timesAnswered += 1
        }
        
        // AND RETURN getListOfPercentagesFor THAT ARRAY
        return getListOfPercentagesFor(answers, timesAnswered: timesAnswered)
    }
    
    // MARK: - average score for question - curr. not used
    /*func getAvgScoreForQuestion (question: Question) -> Float? {
        if question.timesAnswered == 0 { return nil }
        
        var totalScore = 0
        for i in 0..<question.stats.answers.count {
            totalScore += (i+1) * question.stats.answers[i]
        }
        
        let avgScore: Float = Float(totalScore) / Float(question.timesAnswered)
        return avgScore
    }
    
    func getAvgScoreForQuestionForTime (question: Question, time: TimeInterval) -> Float? {
        getAvgScoreForQuestion(question: question)
    }*/
    
    // MARK: - most used behaviors for question
    func getMostUsedBehaviors (forList list: [[UUID:Int]]) -> [[Behavior?]]? {
        var listOfbehaviors = [[Behavior?]]()
            
        for answer in list {
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
        else { return listOfbehaviors }
        
    }
    
    func getMostUsedBehaviorsForQuestionForTime (question: Question, time: TimeInterval) -> [[Behavior?]]? {
        if question.timesAnswered == 0 { return nil }
        
        // create equivalence to question.stats.selectedBehaviors
        var listOfPossibleAnswers = [[UUID:Int]]()
        for _ in question.stats.answers { listOfPossibleAnswers.append([UUID:Int]()) }
        
        for answer in question.answers.reversed() {
            // answer was given outside of time interval
            if answer.dateOfAnswer.timeIntervalSince(Date()-time) < 0 {
                break
            }
                    
            for behavior in answer.behaviors {
                if let occ = listOfPossibleAnswers[answer.answer][behavior.id] {
                    listOfPossibleAnswers[answer.answer][behavior.id] = occ+1
                } else {
                    listOfPossibleAnswers[answer.answer][behavior.id] = 1
                }                
            }
        }
        
        // get list of behaviors
        return getMostUsedBehaviors(forList: listOfPossibleAnswers)
    }
    
    func getMostUsedBehaviorsForQuestion (question: Question) -> [[Behavior?]]? {
        if question.timesAnswered == 0 { return nil }
        return getMostUsedBehaviors(forList: question.stats.selectedBehaviors)
    }
    
}
