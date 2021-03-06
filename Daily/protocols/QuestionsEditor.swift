//
//  QuestionsEditor.swift
//  Daily
//
//  Created by Nicolai Schneider on 21.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

protocol QuestionsEditorDelegate {
    // questions
    func addQuestion (question: Question)
    func deleteQuestion (questionID: UUID)
    func updateStatsOfQuestion (questionID: UUID, answerIndex: Int, behaviors: [Behavior])
    func isQuestionDuplicate (question: String) -> Bool
}
