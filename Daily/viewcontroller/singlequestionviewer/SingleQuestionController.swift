//
//  SingleQuestionController.swift
//  Daily
//
//  Created by Nicolai Schneider on 31.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class SingleQuestionController: SingleQuestionControllerDelegate {
    var view: UIViewController!
    var statsComp: StatsComputer!
    var questionsDelegate: QuestionsEditorDelegate!
    
    var question: Question!
    
    init(view: UIViewController, question: Question) {
        self.view = view
        self.question = question
        self.statsComp = StatsComputer()
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
    
    func getPercentagesString () -> [String] {
        if let scores = statsComp.getAvgStatsForQuestion(question: question) {
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
        if let scores = statsComp.getAvgStatsForQuestion(question: question) {
            var perscScores = [Float]()
            for val in scores {
                perscScores.append(val/100)
            }
            return perscScores
        } else {
            return [0]
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
    
    func getBehaviors () -> [[Behavior?]] {
        if let behaviors = statsComp.getMostUsedBehaviorsForQuestion(question: question) {
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
    
    private func getQuestionType() -> String {
        let type = question.type
        let typeString = TypeMgr.getTextOfType(type!)
        return typeString
    }
    
    private func getTimesAnswered() -> String {
        return String(question.timesAnswered) + " times"
    }
    
    private func getDateOfCreation() -> String {
        let date = question.dateOfCreation
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
}
