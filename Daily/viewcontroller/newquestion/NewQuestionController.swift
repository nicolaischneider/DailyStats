//
//  NewQuestionController.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class NewQuestionController {
    
    var view: NewQuestionVC!
    
    var delegate: QuestionsEditorDelegate!
    
    private var questionStr: String?
    private var questionType: QuestionType?
    private var questionColor: Colors?
    
    init(view: NewQuestionVC) {
        self.view = view
    }
        
    func dismissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func updateQuestion(question: String) {
        self.questionStr = question
    }
    
    func updateTypeOfQuestion(type: QuestionType) {
        self.questionType = type
    }
    
    func updateColorOfQuestion(color: Colors) {
        self.questionColor = color
    }
    
    func getSelectedColor() -> Colors? {
        return questionColor
    }
    
    func getColorForIndex(index: Int) -> Colors {
        switch index {
            case 0: return .lambsGreen
            case 1: return .costalBlue
            case 2: return .desertSand
            case 3: return .coral
            case 4: return .terracotta
            default: return .defaultCol
        }
    }
    
    func addQuestion() {
        guard let quest = questionStr else {
            view.showError(error: "Question is missing")
            return
        }
        
        guard let _ = questionType else {
            view.showError(error: "Choose a Type")
            return
        }
        
        guard let _ = questionColor else {
            view.showError(error: "Choose a color")
            return
        }
        
        if delegate.isQuestionDuplicate(question: quest) {
            view.showError(error: "Question already exists")
            return
        }
        
        let newQuestion = Question(question: questionStr!, type: questionType!, color: questionColor!)
        delegate.addQuestion(question: newQuestion)
        
        dismissVC()
    }
    
}
