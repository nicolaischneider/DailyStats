//
//  SingleQuestionVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class SingleQuestionVC: UIViewController, SingleQuestionVCDelegate {
    var controller: SingleQuestionController!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateofCreationLabel: UILabel!
    @IBOutlet weak var timesAnsweredLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        controller.deleteQuestion()
    }
    
    @IBAction func quitAction(_ sender: Any) {
        controller.dimissVC()
    }
    
    private func setupObjects () {
        // setup textview
        questionTextView.isSelectable = false
        questionTextView.isEditable = false
        questionTextView.isScrollEnabled = false
        
        // setup question
        questionTextView.text = controller.getQuestion()
        bgView.backgroundColor = controller.getQuestionColor()
        typeLabel.text = "Type: " + controller.getQuestionType()
        timesAnsweredLabel.text = "Times answered: " + controller.getTimesAnswered()
        dateofCreationLabel.text = "Date of Creation: " + controller.getDateOfCreation()
    }
}
