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
    var view: AnswerVC!
    var delegate: QuestionsEditorDelegate!
    var listOfQuestions = [Question]()
        
    init(view: AnswerVC, questions: [Question]) {
        self.view = view
        self.listOfQuestions = questions
    }
    
    func dismissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func getNumOfQuestions() -> Int {
        return listOfQuestions.count
    }
    
    func getQuestionAtIndex(index: Int) -> Question {
        return listOfQuestions[index]
    }
    
    func answeredQuestion (questionTag: Int, answer: Int) {
        let questionID = listOfQuestions[questionTag].tag
        delegate.updateStatsOfQuestion(questionID: questionID!, answerIndex: answer)
        
        // check for last question
        if questionTag == getNumOfQuestions()-1 {
            dismissVC()
        }
    }
}
