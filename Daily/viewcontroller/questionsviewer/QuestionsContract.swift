//
//  QuestionsContract.swift
//  Daily
//
//  Created by Nicolai Schneider on 26.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

protocol QuestionsVCDelegate {
    var controller: QuestionsController! { get set }
    
    func reloadData()
    func reloadLastAnswered ()
}

protocol QuestionsControllerDelegate {
    var view: QuestionsVC! { get set }
    var dataManager: DataManager! { get set }
    
    func getQuestionAtIndex(index: Int) -> Question
    func getNumberofQuestions() -> Int
    func getLastAnswered () -> String
    func getStatsForQuestionAtIndex (index: Int) -> String
    func isAnswerButtonActivated () -> Bool
    
    // navigation
    func navigateToAddQuestion ()
    func navigateToSingleQuestion (questionIndex: Int)
    func navigateToAnswerQuestion ()
    func navigateToBehaviorView ()
    func navigateToOthers ()
}
