//
//  QuestionType.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

enum QuestionType: Int, Codable {
    case yesNo
    case scale1to5
}

class TypeMgr: NSObject {
    static func getTextOfType (_ type: QuestionType) -> String {
        switch type {
            case .yesNo: return "Yes/No"
            case .scale1to5: return "Scale 1-5"
        }
    }
}
