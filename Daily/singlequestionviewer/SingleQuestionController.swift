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
    var question: Question!
    
    func dimissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func deleteQuestion() {
        // TODO
    }
    
    func getQuestion() -> String {
        return question.question
    }
    
    func getQuestionType() -> String {
        let type = question.type
        let typeString = type?.getTypeText()
        return typeString!
    }
    
    func getTimesAnswered() -> String {
        return String(question.timesAnswered)
    }
    
    func getDateOfCreation() -> String {
        let date = question.dateOfCreation
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    func getQuestionColor() -> UIColor {
        return question.color
    }
    
    init(view: UIViewController, question: Question) {
        self.view = view
        self.question = question
    }
}
