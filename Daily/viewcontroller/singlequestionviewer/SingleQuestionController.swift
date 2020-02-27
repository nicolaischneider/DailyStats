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
    var delegate: QuestionsEditorDelegate!
    var question: Question!
    
    init(view: UIViewController, question: Question) {
        self.view = view
        self.question = question
    }
    
    func dimissVC() {
        view.dismiss(animated: true, completion: nil)
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
            self.delegate.deleteQuestion(questionID: self.question.tag)
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
    
    func getStat (type: QuestionStatType) -> (String, String) {
        switch type {
            case .type: return ("Type", getQuestionType())
            case .dateOfCreation: return ("Created", getDateOfCreation())
            case .timesAnswered: return ("Answered", getTimesAnswered())
            case .stats: return ("Stats", getStats())
        }
    }
    
    private func getQuestionType() -> String {
        let type = question.type
        let typeString = type?.getTypeText()
        return typeString!
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
    
    private func getStats () -> String {
        switch question.type.getType() {
        case .yesNo:
            if let scores = StatsComputer.avgStatsForYesNoQuestion(question: question) {
                return String(scores.0) + "% Yes; " + String(scores.1) + "% No"
            } else {
                return "No Stats available yet."
            }
        case .scale1to5:
            if let score = StatsComputer.avgStatsForScale1to5Question(question: question) {
                return "Average Score: " + String(score)
            }
            return "No Stats available yet."
        }
    }
}
