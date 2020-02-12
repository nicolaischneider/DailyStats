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
    var question: Question!
        
    func dismissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func updateQuestion(question: String) {
        self.question.question = question
    }
    
    func updateTypeOfQuestion(type: QuestionTypes) {
        self.question.type = QuestionType(type: type)
    }
    
    func updateColorOfQuestion(color: UIColor) {
        self.question.color = color
    }
    
    func getSelectedColor() -> UIColor? {
        return question.color
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
        guard let _ = question.question else {
            print("Question is missing")
            return
        }
        
        guard let _ = question.type else {
            print("Type is missing")
            return
        }
        
        guard let _ = question.color else {
            print("Color is missing")
            return
        }
        
        // add question
        dismissVC()
    }
    
    init(view: UIViewController) {
        self.view = view
        question = Question()
    }
    
}
