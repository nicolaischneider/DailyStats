//
//  Question.swift
//  Daily
//
//  Created by Nicolai Schneider on 26.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

struct Question: Codable {
    var tag: UUID!
    var question: String!
    var type: QuestionType!
    var color: Colors!
    var timesAnswered: Int!
    var dateOfCreation: Date!
    var lastAnswered: Date?
    var answers: [Answer]!
    var stats: Stats!
    
    init(question: String, type: QuestionType, color: Colors) {
        self.tag = UUID()
        self.question = question
        self.type = type
        self.color = color
        self.timesAnswered = 0
        self.dateOfCreation = Date(timeIntervalSinceNow: 0)
        self.answers = [Answer]()
        
        var possibleAns: Int!
        switch type {
            case .scale1to5: possibleAns = 5
            case .yesNo: possibleAns = 2
        }
        self.stats = Stats(possibleAnswers: possibleAns)
    }
    
    mutating func updateStats (ans: Int, behaviors: [Behavior]) {
        self.timesAnswered += 1
        self.answers.append(Answer(ans: ans, date: Date(timeIntervalSinceNow: .zero), behaviors: behaviors))
        self.lastAnswered = Date(timeIntervalSinceNow: .zero)
        self.stats.updateStats(answer: ans, behaviors: behaviors)
    }
    
    mutating func updateStats_ (ans: Int, behaviors: [Behavior], _time: Date) {
        self.timesAnswered += 1
        self.answers.append(Answer(ans: ans, date: _time, behaviors: behaviors))
        self.lastAnswered = Date(timeIntervalSinceNow: .zero)
        self.stats.updateStats(answer: ans, behaviors: behaviors)
    }
    
    public static func updateQuestions (listOfQuestions: [Question]) {
        let questionsData = try! JSONEncoder().encode(listOfQuestions)
        UserDefaults.standard.set(questionsData, forKey: "userQuestions")
    }
    
    public static func loadQuestions() -> [Question]? {
        if let questionData = UserDefaults.standard.data(forKey: "userQuestions") {
            let questionsArray = try! JSONDecoder().decode([Question].self, from: questionData)
            return questionsArray
        }
        return nil
    }
}
