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
    private var questionColor: UIColor?
    
    init(view: UIViewController) {
        self.view = view
    }
        
    func dismissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func updateQuestion(question: String) {
        self.questionStr = question
    }
    
    func updateTypeOfQuestion(type: QuestionTypes) {
        self.questionType = QuestionType(type: type)
    }
    
    func updateColorOfQuestion(color: UIColor) {
        self.questionColor = color
    }
    
    func getSelectedColor() -> UIColor? {
        return questionColor
    }
    
    func getColorForIndex(index: Int) -> UIColor {
        switch index {
            case 0: return ColorPicker.getColor(.lambsGreen)
            case 1: return ColorPicker.getColor(.costalBlue)
            case 2: return ColorPicker.getColor(.desertSand)
            case 3: return ColorPicker.getColor(.coral)
            case 4: return ColorPicker.getColor(.terracotta)
            default: return .black
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
        // ADD DELEGATE TO TALK TO MAIN CONTROLLER
        // MAIN CONTROLLER SHOULD THEN TALK TO DATA MANAGER
        delegate.addQuestion(question: newQuestion)
        
        // add question
        dismissVC()
    }
    
}
