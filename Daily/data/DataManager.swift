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
        
        // THREE TEST QUESTIONS
        let quest1 = Question(question: "How happy are you?", type: QuestionType.init(type: .scale1to5), color: .green)
        let quest2 = Question(question: "Did you feel any dizziness when waking up?", type: QuestionType.init(type: .yesNo), color: .red)
        let quest3 = Question(question: "Are you excited for today?", type: QuestionType.init(type: .yesNo), color: .yellow)
        listOfQuestions.append(quest1)
        listOfQuestions.append(quest2)
        listOfQuestions.append(quest3)
        
        if let questionsArray = Question.loadQuestions() {
            listOfQuestions = questionsArray
            print("data extracted")
        }
        
        print("data loaded")
    }
    
    func updateData () {
        Question.updateQuestions(listOfQuestions: listOfQuestions)
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
                let stat = Stats(ans: answerIndex, date: Date(timeIntervalSinceNow: .zero))
                listOfQuestions[i].stats.append(stat)
                listOfQuestions[i].timesAnswered += 1
                listOfQuestions[i].lastAnswered = Date(timeIntervalSinceNow: .zero)
                break
            }
        }
        updateData()
    }
}
