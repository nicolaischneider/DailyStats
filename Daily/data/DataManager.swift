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
    
    private var listOfQuestions = [Question]()
    
    func loadData () {
        
        // get three test questions
        let quest1 = Question(question: "How happy are you?", type: QuestionType.init(type: .scale1to5), color: ColorPicker.getColor(.green))
        
        let quest2 = Question(question: "Did you feel any dizziness when waking up?", type: QuestionType.init(type: .yesNo), color: ColorPicker.getColor(.red))
        
        let quest3 = Question(question: "Are you excited for today?", type: QuestionType.init(type: .yesNo), color: ColorPicker.getColor(.yellow))
        
        listOfQuestions.append(quest1)
        listOfQuestions.append(quest2)
        listOfQuestions.append(quest3)
        
        print("data loaded")
    }
    
    func updateData () {
        
    }
    
    func getLastAnswered () -> Date? {
        // todo: go through all questions and find time that is furthes away from now
        return Date(timeIntervalSinceNow: .zero)
    }
        
    func getQuestions () -> [Question] {
        return listOfQuestions
    }
    
    func addQuestion (question: Question) {
        listOfQuestions.append(question)
        updateData()
    }
    
    func deleteQuestion (questionID: UUID) {
        for i in 0..<listOfQuestions.count {
            if questionID == listOfQuestions[i].tag {
                listOfQuestions.remove(at: i)
                break
            }
        }
        updateData()
    }
    
    func updateStatsOfQuestion (questionID: UUID, answerIndex: Int) {
        for i in 0..<listOfQuestions.count {
            if questionID == listOfQuestions[i].tag {
                listOfQuestions[i].stats[answerIndex] += 1
                listOfQuestions[i].lastAnswered = Date(timeIntervalSinceNow: .zero)
                break
            }
        }
        updateData()
    }
}
