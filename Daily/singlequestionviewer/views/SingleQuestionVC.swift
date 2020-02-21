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
    @IBOutlet weak var questionTextView: UITextView!
    
    // stats
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.backgroundColor = .clear
        sv.axis = .vertical
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
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
        
        // setup stack view
        for type in QuestionStatType.allCases {
            let statsView = StatsCell()
            statsView.setupContent(content: controller.getStat(type: type))
            stackView.addArrangedSubview(statsView)
        }
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        //stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
}
