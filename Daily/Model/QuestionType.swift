//
//  QuestionType.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

enum QuestionTypes {
    case yesNo
    case scale1to5
}

class QuestionType {
    private var questionType: QuestionTypes!
    private var typeText: String!
    
    func getType () -> QuestionTypes {
        return questionType
    }
    
    func getTypeText () -> String {
        return typeText
    }
    
    init(type: QuestionTypes) {
        questionType = type
        typeText = generateTypeText(type: type)
    }
    
    private func generateTypeText (type: QuestionTypes) -> String {
        switch type {
            case QuestionTypes.yesNo: return "Yes/No"
            case QuestionTypes.scale1to5: return "Scale 1-5"
        }
    }
}
