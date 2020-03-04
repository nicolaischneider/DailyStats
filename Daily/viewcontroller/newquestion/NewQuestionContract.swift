//
//  NewQuestionContract.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

protocol NewQuestionVCDelegate {
    var controller: NewQuestionController! { get set }
}

protocol NewQuestionControllerDelegate {
    var view: UIViewController! { get set }
    
    func dismissVC ()
    func addQuestion ()
    func updateQuestion (question: String)
    func updateTypeOfQuestion (type: QuestionType)
    func updateColorOfQuestion (color: Colors)
    func getColorForIndex (index: Int) -> Colors
    func getSelectedColor () -> Colors?
}
