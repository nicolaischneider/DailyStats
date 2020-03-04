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
    var behaviorDelegate: BehaviorDelegate!
    
    var listOfQuestions = [Question]()
    var listOfAnswers = [Int]()
        
    init(view: AnswerVC, questions: [Question]) {
        self.view = view
        self.listOfQuestions = questions
    }
    
    func getDelegate () -> BehaviorDelegate {
        return behaviorDelegate
    }
    
    func closeAction () {
        // Alert notification
        let alert = UIAlertController(title: "Are you sure?", message: "None of your answers will be saved.", preferredStyle: .alert)
        
        // cancel quit and keep playing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            return
        }
        alert.addAction(cancelAction)
        
        // quit the game
        let yesAction = UIAlertAction(title: "Leave", style: .destructive) { action in
            self.dismissVC()
        }
        alert.addAction(yesAction)
        view.present(alert, animated: true, completion: nil)
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
    
    func addBhevaviors (selectedBehaviors: [Bool]) {
        let listOfBehaviors = behaviorDelegate.getListOfBehaviors()
        var behaviorsToAdd = [Behavior]()
        
        // get all behaviors rto add to stats
        for i in 0..<selectedBehaviors.count {
            if selectedBehaviors[i] {
                behaviorsToAdd.append(listOfBehaviors[i])
            }
        }
        
        if listOfQuestions.count != listOfAnswers.count {
            print("error: list of questions and list of answers doesn't match")
            return
        }
                
        // update stats
        for j in 0..<listOfQuestions.count {
            let questionID = listOfQuestions[j].tag
            let answerIndex = listOfAnswers[j]
            delegate.updateStatsOfQuestion(questionID: questionID!, answerIndex: answerIndex, behaviors: behaviorsToAdd)
        }
        
        // all stats were update: go back to main menu
        dismissVC()
    }
    
    func answeredQuestion (questionTag: Int, answer: Int) {
        listOfAnswers.append(answer)
    }
}
