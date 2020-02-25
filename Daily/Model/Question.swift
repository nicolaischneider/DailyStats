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
    var stats: [Int]!
    
    init(question: String, type: QuestionType, color: Colors) {
        self.tag = UUID()
        self.question = question
        self.type = type
        self.color = color
        self.timesAnswered = 0
        self.dateOfCreation = Date(timeIntervalSinceNow: 0)
        
        // get stats array ready
        switch type.getType() {
            case .yesNo: self.stats = [0,0]
            case .scale1to5: self.stats = [0,0,0,0,0]
        }
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
