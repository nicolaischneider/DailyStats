//
//  AnswerController.swift
//  Daily
//
//  Created by Nicolai Schneider on 09.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class AnswerController: AnswerControllerDelegate {
    var view: UIViewController!
        
    init(view: UIViewController) {
        self.view = view
    }
    
    func dismissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func getNumOfQuestions() -> Int {
        return 4
    }
    
    func getQuestionAtIndex(index: Int) -> Question {
        let question = Question()
        question.question = "This is my test question and it shoukld be a bit longer than the usual question a user might pose."
        question.type = QuestionType(type: QuestionTypes.yesNo)
        question.color = ColorPicker.getColor(.desertSand)
        return question
    }
    
    func answeredQuestion (questionTag: Int, answer: Int) {
        // check for last question
        if questionTag == getNumOfQuestions()-1 {
            dismissVC()
        }
    }
}
