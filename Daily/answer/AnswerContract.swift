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
}

protocol AnswerControllerDelegate {
    var view: UIViewController! { get set }
    
    func dismissVC ()
    func getQuestionAtIndex (index: Int) -> Question
    func getNumOfQuestions () -> Int
}
