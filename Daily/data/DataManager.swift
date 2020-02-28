//
//  DataManager.swift
//  Daily
//
//  Created by Nicolai Schneider on 20.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    override init() {
        super.init()
        loadData()
    }
    
    // stored data
    private var listOfQuestions = [Question]()
    private var listOfBehaviors = [Behavior]()
    
    func loadData () {
        loadQuestions()
        loadBehaviors()
        print("data loaded")
    }
    
    // MARK: - QUESTION DATA
    private func loadQuestions () {
        if let questionsArray = Question.loadQuestions() {
            listOfQuestions = questionsArray
            print("questions extracted")
        } else {
            // THREE TEST QUESTIONS
            let quest1 = Question(question: "How happy are you?", type: QuestionType.init(type: .scale1to5), color: .lambsGreen)
            let quest2 = Question(question: "Did you feel any dizziness when waking up?", type: QuestionType.init(type: .yesNo), color: .costalBlue)
            let quest3 = Question(question: "Are you excited for today?", type: QuestionType.init(type: .yesNo), color: .desertSand)
            listOfQuestions.append(quest1)
            listOfQuestions.append(quest2)
            listOfQuestions.append(quest3)
        }
    }
    
    private func updateQuestionData () {
        Question.updateQuestions(listOfQuestions: listOfQuestions)
    }
        
    func getQuestions () -> [Question] {
        return listOfQuestions
    }
    
    func addQuestion (question: Question) {
        listOfQuestions.append(question)
        updateQuestionData()
    }
    
    func deleteQuestion (questionID: UUID) {
        for i in 0..<listOfQuestions.count {
            if questionID == listOfQuestions[i].tag {
                listOfQuestions.remove(at: i)
                break
            }
        }
        updateQuestionData()
    }
    
    func updateStatsOfQuestion (questionID: UUID, answerIndex: Int) {
        for i in 0..<listOfQuestions.count {
            if questionID == listOfQuestions[i].tag {                
                let stat = Stats(ans: answerIndex, date: Date(timeIntervalSinceNow: .zero))
                listOfQuestions[i].stats.append(stat)
                listOfQuestions[i].timesAnswered += 1
                listOfQuestions[i].lastAnswered = Date(timeIntervalSinceNow: .zero)
                break
            }
        }
        updateQuestionData()
    }
    
    func getLastAnswered () -> Date? {
        var mostCurrentDate = Date(timeIntervalSince1970: .zero)
        var dateWasChanged = false
        
        for question in listOfQuestions {
            if let _date = question.lastAnswered {
                if _date > mostCurrentDate {
                    mostCurrentDate = _date
                    dateWasChanged = true
                }
            }
        }
        
        if !dateWasChanged { return nil }
        else { return mostCurrentDate }
    }
    
    // MARK: - BEHAVIOR DATA
    private func loadBehaviors () {
        if let behaviorArray = Behavior.loadBehaviors() {
            listOfBehaviors = behaviorArray
            print("behaviors extracted")
        } else {
            listOfBehaviors.append(Behavior(behavior: "weed", color: .desertSand))
            listOfBehaviors.append(Behavior(behavior: "exercise", color: .costalBlue))
            listOfBehaviors.append(Behavior(behavior: "slept well", color: .coral))
            listOfBehaviors.append(Behavior(behavior: "coffee", color: .desertSand))
            listOfBehaviors.append(Behavior(behavior: "went outside", color: .lambsGreen))
            listOfBehaviors.append(Behavior(behavior: "meditation", color: .coral))
            listOfBehaviors.append(Behavior(behavior: "relaxation", color: .terracotta))
            listOfBehaviors.append(Behavior(behavior: "stressful day", color: .costalBlue))
        }
    }
    
    private func updateBehaviorData () {
        Behavior.updateBehaviors(listOfBehaviors: listOfBehaviors)
    }
    
    func getBehaviors () -> [Behavior] {
        return listOfBehaviors
    }
    
    func addBehavior (behavior: Behavior) {
        listOfBehaviors.append(behavior)
        updateBehaviorData()
    }
    
    func updateBehavior (behavior: Behavior) {
        let id = behavior.id
        for i in 0..<listOfBehaviors.count {
            if id == listOfBehaviors[i].id {
                listOfBehaviors[i] = behavior
                break
            }
        }
        updateBehaviorData()
    }
    
    func deleteBehavior (behaviorID: UUID) {
        for i in 0..<listOfBehaviors.count {
            if behaviorID == listOfBehaviors[i].id {
                listOfBehaviors.remove(at: i)
                break
            }
        }
        updateBehaviorData()
    }
}
