//
//  SingleQuestionController.swift
//  Daily
//
//  Created by Nicolai Schneider on 31.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class SingleQuestionController {
    
    var view: SingleQuestionVC!
    var statsComp: StatsComputer!
    var questionsDelegate: QuestionsEditorDelegate!
    
    var question: Question!
    
    var activeStatsTimePeriod: StatsTimePeriod!
    
    init(view: SingleQuestionVC, question: Question) {
        self.view = view
        self.question = question
        self.statsComp = StatsComputer()
        activeStatsTimePeriod = .allTime
    }
    
    func setDelegates (qDelegate: QuestionsEditorDelegate, bDelegate: BehaviorDelegate) {
        self.questionsDelegate = qDelegate
        self.statsComp.delegate = bDelegate
    }
    
    func dimissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func shouldShowStats () -> Bool {
        if question.timesAnswered > 0 { return true }
        else { return false }
    }
    
    func deleteQuestion() {
        // Alert notification
        let alert = UIAlertController(title: "Are you sure?", message: "Your Question and all its Stats will be deleted forever.", preferredStyle: .alert)
        
        // cancel quit and keep playing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        alert.addAction(cancelAction)
        
        // quit the game
        let yesAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.questionsDelegate.deleteQuestion(questionID: self.question.tag)
            self.dimissVC()
        }
        alert.addAction(yesAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    func getQuestion() -> String {
        return question.question
    }
    
    func getQuestionColor() -> Colors {
        return question.color
    }
    
    func getQuestionStats () -> Stats {
        return question.stats
    }
    
    private func get1MonthAgo () -> TimeInterval {
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let day:TimeInterval = 24 * hour
        let month: TimeInterval = day*30
        return month
    }
    
    private func get6MonthAgo () -> TimeInterval {
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let day:TimeInterval = 24 * hour
        let month: TimeInterval = day*30
        let month6: TimeInterval = month*6
        return month6
    }
    
    private func get2daysago () -> TimeInterval {
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let day:TimeInterval = 24 * hour
        let day2: TimeInterval = day*2
        return day2
    }
    
    private func getScoresForTimePeriod () -> [Float]? {
        switch activeStatsTimePeriod {
        case .allTime: return statsComp.getAvgStatsForQuestion(question: question)
        case .last6Months: return statsComp.getAvgStatsForQuestionForTime(question: question, time: get6MonthAgo())
        case .lastMonth: return statsComp.getAvgStatsForQuestionForTime(question: question, time: get1MonthAgo())
        case .none:
            return [1]
        }
    }
    
    func getPercentagesString () -> [String] {
        if let scores = getScoresForTimePeriod() {
            var scoresString = [String]()
            for val in scores {
                let valString = String(format: "%.1f", val) + "%"
                scoresString.append(valString)
            }
            return scoresString
        } else {
            return ["-%"]
        }
    }
    
    func getPercentagesFloat () -> [Float] {
        if let scores = getScoresForTimePeriod() {
            var perscScores = [Float]()
            for val in scores {
                perscScores.append(val/100)
            }
            return perscScores
        } else {
            return [-1]
        }
    }
    
    func getPossibleAnswers () -> [String] {
        switch question.type {
            case .yesNo: return ["Yes","No"]
            case .scale1to5: return ["1","2","3","4","5"]
        case .none:
            print("error: non existing type")
            return [""]
        }
    }
    
    private func getBehaviorsForTimePeroiod () -> [[Behavior?]]? {
        switch activeStatsTimePeriod {
        case .allTime: return statsComp.getMostUsedBehaviorsForQuestion(question: question)
        case .last6Months: return statsComp.getMostUsedBehaviorsForQuestionForTime(question: question, time: get6MonthAgo())
        case .lastMonth: return statsComp.getMostUsedBehaviorsForQuestionForTime(question: question, time: get1MonthAgo())
        case .none:
            return [[]]
        }
    }
    
    func getBehaviors () -> [[Behavior?]] {
        if let behaviors = getBehaviorsForTimePeroiod() {
            return behaviors
        } else {
            var emptyBehavior = [[Behavior?]]()
            emptyBehavior.append([nil])
            return emptyBehavior
        }
    }
    
    func getStat (type: QuestionStatType) -> (String, String) {
        switch type {
            case .type: return ("Type", getQuestionType())
            case .dateOfCreation: return ("Created", getDateOfCreation())
            case .timesAnswered: return ("Answered", getTimesAnswered())
        }
    }
    
    func getButtonAtIndex (index: Int) -> (String,Bool,StatsTimePeriod)? {
        switch index {
            case 0: return ("all-time",true,.allTime)
            case 1: return ("6 months",false,.last6Months)
            case 2: return ("last month",false,.lastMonth)
        default:
            return nil
        }
    }
    
    func updateStatsTimePeriod (timePeriod: StatsTimePeriod) {
        activeStatsTimePeriod = timePeriod
        view.reloadData()
    }
    
    private func getQuestionType() -> String {
        let type = question.type
        let typeString = TypeMgr.getTextOfType(type!)
        return typeString
    }
    
    private func getTimesAnswered() -> String {
        if question.timesAnswered == 1 {
            return String(question.timesAnswered) + " time"
        } else {
            return String(question.timesAnswered) + " times"
        }
    }
    
    private func getDateOfCreation() -> String {
        let date = question.dateOfCreation
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
}
