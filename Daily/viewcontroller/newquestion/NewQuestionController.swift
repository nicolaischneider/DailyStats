//
//  NewQuestionController.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class NewQuestionController: NewQuestionControllerDelegate {
    var view: UIViewController!
    
    var delegate: QuestionsEditorDelegate!
    
    private var questionStr: String?
    private var questionType: QuestionType?
    private var questionColor: Colors?
    
    init(view: UIViewController) {
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
        guard let _ = questionStr else {
            print("Question is missing")
            return
        }
        
        guard let _ = questionType else {
            print("Type is missing")
            return
        }
        
        guard let _ = questionColor else {
            print("Color is missing")
            return
        }
        
        let newQuestion = Question(question: questionStr!, type: questionType!, color: questionColor!)
        delegate.addQuestion(question: newQuestion)
        
        dismissVC()
    }
    
}
