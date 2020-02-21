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
        delegate.deleteQuestion(questionID: question.tag)
        dimissVC()
    }
    
    func getQuestion() -> String {
        return question.question
    }
    
    func getQuestionColor() -> UIColor {
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
        return "Yes: 10%, No: 90%"
    }
}
