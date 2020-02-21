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
    
    var view: QuestionsVC!
    var dataManager: DataManager!
    
    init(view: QuestionsVC) {
        self.view = view
        self.dataManager = DataManager()
    }
    
    func getNumberofQuestions() -> Int {
        let list = dataManager.getQuestions()
        return list.count
    }
    
    func getQuestionAtIndex(index: Int) -> Question {
        let list = dataManager.getQuestions()
        return list[index]
    }
    
    func getStatsForQuestionAtIndex(index: Int) -> String {
        let list = dataManager.getQuestions()
        let question = list[index]
        
        // case: not answered yet
        if question.timesAnswered == 0 {
            return "Average Score: -"
        }
        
        switch question.type.getType() {
        case .yesNo:
            let yesScore: Float = Float((question.stats[0] / question.timesAnswered) * 100)
            let noScore: Float = Float((question.stats[1] / question.timesAnswered) * 100)
            return String(yesScore) + "% Yes; " + String(noScore) + "% No"
        case .scale1to5:
            var score: Float = 0
            for i in 0..<question.stats.count {
                score += Float(i+1) * Float(question.stats[i])
            }
            score = score / Float(question.timesAnswered)
            
            return "Average Score: " + String(score)
        }
    }
    
    func getLastAnswered() -> String {
        if let lastAnswered = dataManager.getLastAnswered() {
            
            // check if user answered the day before as last answered to write yesterday instead
            
            let dateForm = DateFormatter()
            dateForm.dateFormat = "dd.MM.yy"
            let lastAnsweredStr = dateForm.string(from: lastAnswered)
            return "Last answered: " + lastAnsweredStr
        } else {
            return ""
        }
    }
    
    func navigateToAddQuestion() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newQuestionController = storyBoard.instantiateViewController(withIdentifier: "NewQuestionViewController") as! NewQuestionVC
        
        newQuestionController.controller = NewQuestionController(view: newQuestionController)
        newQuestionController.controller.delegate = self
        
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
        singleQuestionController.controller.delegate = self
        
        // segue
        singleQuestionController.modalPresentationStyle = .fullScreen
        view.present(singleQuestionController, animated:true, completion:nil)
    }
    
    func navigateToAnswerQuestion() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let answerController = storyBoard.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerVC
        
        // GIVE ANSWER CONTROLLER THE LIST OF QUESTIONS
        // CHECK WHICH ONES HAVE ALREADY BEEN ANSWERED TODAY
        
        let questions = dataManager.getQuestions()
        answerController.controller = AnswerController(view: answerController, questions: questions)
        
        // segue
        answerController.modalPresentationStyle = .fullScreen
        view.present(answerController, animated:true, completion:nil)
    }
    
    func navigateToOthers() {
        //todo
    }
    
    private func reloadData () {
        view.reloadData()
    }
    
    private func reloadLastAnswered () {
        view.reloadLastAnswered()
    }
}

extension QuestionsController: QuestionsEditorDelegate {
    func addQuestion(question: Question) {
        dataManager.addQuestion(question: question)
        reloadData()
    }
    
    func deleteQuestion(questionID: UUID) {
        dataManager.deleteQuestion(questionID: questionID)
        reloadData()
    }
    
    func updateStatsOfQuestion(questionID: UUID, answerIndex: Int) {
        dataManager.updateStatsOfQuestion(questionID: questionID, answerIndex: answerIndex)
        reloadData()
        reloadLastAnswered()
    }
}
