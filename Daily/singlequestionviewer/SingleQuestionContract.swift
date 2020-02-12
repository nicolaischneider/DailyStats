//
//  SingleQuestionContract.swift
//  Daily
//
//  Created by Nicolai Schneider on 31.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

protocol SingleQuestionVCDelegate {
    var controller: SingleQuestionController! { get set }
}

protocol SingleQuestionControllerDelegate {
    var view: UIViewController! { get set }
    var question: Question! { get set }
    
    func dimissVC ()
    func deleteQuestion ()
    func getQuestion () -> String
    func getQuestionType () -> String
    func getTimesAnswered () -> String
    func getDateOfCreation () -> String
    func getQuestionColor () -> UIColor
}
