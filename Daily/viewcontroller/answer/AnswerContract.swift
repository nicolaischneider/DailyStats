//
//  AnswerContract.swift
//  Daily
//
//  Created by Nicolai Schneider on 09.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

protocol AnswerViewControllerDelegate {
    var controller: AnswerController! { get set }
    
    func scrollToNextItem(tag: Int)
}

protocol AnswerControllerDelegate {
    var view: AnswerVC! { get set }
    
    func dismissVC ()
    func getQuestionAtIndex (index: Int) -> Question
    func getNumOfQuestions () -> Int
    func addBhevaviors (selectedBehaviors: [Bool])
}
