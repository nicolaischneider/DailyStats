//
//  QuestionsController.swift
//  Daily
//
//  Created by Nicolai Schneider on 26.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class QuestionsController {
    
    var view: QuestionsVC!
    var dataManager: DataManager!
    var statsComp: StatsComputer!
    
    init(view: QuestionsVC) {
        self.view = view
        self.dataManager = DataManager()
        self.statsComp = StatsComputer()
        self.statsComp.delegate = self
    }
    
    func getNumberofQuestions() -> Int {
        let list = dataManager.getQuestions()
        return list.count
    }
    
    func getQuestionAtIndex (index: Int) -> Question {
        let list = dataManager.getQuestions()
        return list[index]
    }
    
    func getStatsForQuestionAtIndex (index: Int) -> String {
        let list = dataManager.getQuestions()
        let question = list[index]
        
        switch question.type {
        case .yesNo:
            //if let scores = StatsComputer.avgStatsForYesNoQuestion(question: question) {
            if let scores = statsComp.getAvgStatsForQuestion(question: question) {
                return String(scores[0]) + "% Yes; " + String(scores[1]) + "% No"
            } else {
                return "No Stats available yet."
            }
        case .scale1to5:
            if let score = statsComp.getAvgScoreForQuestion(question: question) {
                return "Average Score: " + String(score)
            }
            return "No Stats available yet."
        
        case .none:
            print("error: non existing type")
            return ""
        }
    }
    
    func getLastAnswered () -> String {
        if let lastAnswered = dataManager.getLastAnswered() {
            let calendar = Calendar.current
            if calendar.isDateInYesterday (lastAnswered) { return "Last answered yesterday" }
            if calendar.isDateInToday (lastAnswered) { return "Last answered today" }
            
            let dateForm = DateFormatter()
            dateForm.dateFormat = "dd.MM.yy"
            let lastAnsweredStr = dateForm.string(from: lastAnswered)
            return "Last answered: " + lastAnsweredStr
        } else {
            return ""
        }
    }
    
    func areQuestionsAvailable () -> Bool {
        if dataManager.getQuestions().count > 0 { return true }
        else { return false }
    }
    
    func isAnswerButtonActivated () -> Bool {
        let questions = getListOfQuestionsToAnswer()
        return questions.count > 0
        //return true
    }
    
    private func getListOfQuestionsToAnswer () -> [Question] {
        let questions = dataManager.getQuestions()
        var questsToAnswer = [Question]()
        for question in questions {
            if let _date = question.lastAnswered {
                let cal = Calendar.current
                if !cal.isDateInToday(_date) {
                    questsToAnswer.append(question)
                }
            } else {
                questsToAnswer.append(question)
            }
        }
        return questsToAnswer
    }
        
    func navigateToAddQuestion () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newQuestionController = storyBoard.instantiateViewController(withIdentifier: "NewQuestionViewController") as! NewQuestionVC
        
        newQuestionController.controller = NewQuestionController(view: newQuestionController)
        newQuestionController.controller.delegate = self
        
        // segue
        newQuestionController.modalPresentationStyle = .fullScreen
        view.present(newQuestionController, animated:true, completion:nil)
    }
    
    func navigateToSingleQuestion (questionIndex: Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let singleQuestionController = storyBoard.instantiateViewController(withIdentifier: "SingleQuestionViewController") as! SingleQuestionVC
        
        // get question
        let selectedQuestion = getQuestionAtIndex(index: questionIndex)
        singleQuestionController.controller = SingleQuestionController(view: singleQuestionController, question: selectedQuestion)
        singleQuestionController.controller.setDelegates(qDelegate: self, bDelegate: self)
        //singleQuestionController.controller.questionsDelegate = self
        //singleQuestionController.controller.behaviorDelegate = self
        
        // segue
        singleQuestionController.modalPresentationStyle = .fullScreen
        view.present(singleQuestionController, animated:true, completion:nil)
    }

    func navigateToBehaviorView () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let behaviorController = storyBoard.instantiateViewController(withIdentifier: "BehaviorViewController") as! BehaviorVC
        behaviorController.controller = BehaviorController(view: behaviorController)
        behaviorController.controller.delegate = self
        
        // segue
        behaviorController.modalPresentationStyle = .fullScreen
        view.present(behaviorController, animated:true, completion:nil)
    }
    
    func navigateToAnswerQuestion () {
        
        let questsToAnswer = getListOfQuestionsToAnswer()
        //let questsToAnswer = dataManager.getQuestions()
        
        if questsToAnswer.count == 0 {
            return
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let answerController = storyBoard.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerVC
        
        answerController.controller = AnswerController(view: answerController, questions: questsToAnswer)
        answerController.controller.delegate = self
        answerController.controller.behaviorDelegate = self
        
        // segue
        answerController.modalPresentationStyle = .fullScreen
        view.present(answerController, animated:true, completion:nil)
    }
    
    func navigateToOthers () {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let settingsController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsVC
        settingsController.controller = SettingsController(view: settingsController)
        
        // segue
        settingsController.modalPresentationStyle = .overCurrentContext
        settingsController.modalTransitionStyle = .crossDissolve
        view.present(settingsController, animated:true, completion:nil)
    }
    
    private func reloadData () {
        view.reloadData()
    }
    
    private func reloadLastAnswered () {
        view.reloadLastAnswered()
    }
}

extension QuestionsController: QuestionsEditorDelegate, BehaviorDelegate {
    // MARK: - QUESTIONS
    func addQuestion(question: Question) {
        dataManager.addQuestion(question: question)
        reloadData()
    }
    
    func deleteQuestion(questionID: UUID) {
        dataManager.deleteQuestion(questionID: questionID)
        reloadData()
    }
    
    func updateStatsOfQuestion(questionID: UUID, answerIndex: Int, behaviors: [Behavior]) {
        dataManager.updateStatsOfQuestion(questionID: questionID, answerIndex: answerIndex, behaviors: behaviors)
        reloadData()
        reloadLastAnswered()
    }
    
    func isQuestionDuplicate (question: String) -> Bool {
        return dataManager.isQuestionDuplicate(question: question)
    }
    
    // MARK: - BEHAVIORS
    func addBehavior(behavior: Behavior) {
        dataManager.addBehavior(behavior: behavior)
    }
    
    func updateBehavior(behavior: Behavior) {
        dataManager.updateBehavior(behavior: behavior)
    }
    
    func deleteBehavior(behaviorID: UUID) {
        dataManager.deleteBehavior(behaviorID: behaviorID)
    }
    
    func getListOfBehaviors() -> [Behavior] {
        return dataManager.getBehaviors()
    }
}
