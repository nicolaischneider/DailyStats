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
            let quest1 = Question(question: "How happy were you today?", type: .scale1to5, color: .lambsGreen)
            let quest2 = Question(question: "How productive did you feel today?", type:.scale1to5, color: .costalBlue)
            let quest3 = Question(question: "Were you excited for today when you woke up this morning?", type: .yesNo, color: .desertSand)
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
    
    func updateStatsOfQuestion (questionID: UUID, answerIndex: Int, behaviors: [Behavior]) {
        for i in 0..<listOfQuestions.count {
            if questionID == listOfQuestions[i].tag {
                listOfQuestions[i].updateStats(ans: answerIndex, behaviors: behaviors)
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
            listOfBehaviors.append(Behavior(behavior: "weed", color: .nineteesBlue))
            listOfBehaviors.append(Behavior(behavior: "exercise", color: .aquamarine))
            listOfBehaviors.append(Behavior(behavior: "slept well", color: .rustyOrange))
            listOfBehaviors.append(Behavior(behavior: "alcohol", color: .goldenYellow))
            listOfBehaviors.append(Behavior(behavior: "went outside", color: .aquamarine))
            listOfBehaviors.append(Behavior(behavior: "meditation", color: .beige))
            listOfBehaviors.append(Behavior(behavior: "relaxation", color: .nineteesBlue))
            listOfBehaviors.append(Behavior(behavior: "stressful day", color: .goldenYellow))
            Behavior.updateBehaviors(listOfBehaviors: listOfBehaviors)
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
