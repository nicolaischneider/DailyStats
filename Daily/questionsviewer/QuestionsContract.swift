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
}

protocol QuestionsControllerDelegate {
    var view: UIViewController! { get set }
    
    func dismissVC ()
    func getQuestionAtIndex(index: Int) -> Question
    func getLastAnswered () -> String
    func navigateToAddQuestion ()
    func navigateToSingleQuestion (questionIndex: Int)
    func navigateToAnswerQuestion ()
    func navigateToOthers ()
}
