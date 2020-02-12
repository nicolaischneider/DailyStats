//
//  QuestionsController.swift
//  Daily
//
//  Created by Nicolai Schneider on 26.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class QuestionsController: QuestionsControllerDelegate {
    
    var view: UIViewController!
    
    func dismissVC() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func getQuestionAtIndex(index: Int) -> Question {
        let question = Question()
        // question
        question.question = "This is a test question which hopefully isn't a bit too long."
        
        // type
        question.type = QuestionType(type: QuestionTypes.yesNo)
        
        // color
        question.color = ColorPicker.getColor(Colors.red)
        
        // times played
        question.timesAnswered = 9
        
        // date of creation
        question.dateOfCreation = Date(timeIntervalSince1970: .zero)
        
        switch index {
        case 0:
            question.color = ColorPicker.getColor(Colors.desertSand)
            break
        case 1:
            question.color = ColorPicker.getColor(Colors.costalBlue)
            break
        default:
            question.color = ColorPicker.getColor(Colors.terracotta)
        }
        
        return question
    }
    
    func navigateToAddQuestion() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newQuestionController = storyBoard.instantiateViewController(withIdentifier: "NewQuestionViewController") as! NewQuestionVC
        newQuestionController.controller = NewQuestionController(view: newQuestionController)
        
        // segue
        newQuestionController.modalPresentationStyle = .fullScreen
        view.present(newQuestionController, animated:true, completion:nil)
    }
    
    func navigateToSingleQuestion(questionIndex: Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let singleQuestionController = storyBoard.instantiateViewController(withIdentifier: "SingleQuestionViewController") as! SingleQuestionVC
        
        // get question
        let selectedQuestion = getQuestionAtIndex(index: questionIndex)
        singleQuestionController.controller = SingleQuestionController(view: singleQuestionController, question: selectedQuestion)
        
        // segue
        singleQuestionController.modalPresentationStyle = .fullScreen
        view.present(singleQuestionController, animated:true, completion:nil)
    }
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func getLastAnswered() -> String {
        return "Last answered: yesterday"
    }
    
    func navigateToAnswerQuestion() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let answerController = storyBoard.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerVC
        answerController.controller = AnswerController(view: answerController)
        
        // segue
        answerController.modalPresentationStyle = .fullScreen
        view.present(answerController, animated:true, completion:nil)
    }
    
    func navigateToOthers() {
        //todo
    }
}
