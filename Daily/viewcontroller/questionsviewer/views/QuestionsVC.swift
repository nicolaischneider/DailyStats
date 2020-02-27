//
//  QuestionsVC.swift
//  Daily
//
//  Created by Nicolai on 19.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController, QuestionsVCDelegate {
    
    var controller: QuestionsController!
    
    // buttons
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var behaviorButton: UIButton!
    
    // labels
    @IBOutlet weak var lastAnsweredLabel: UILabel!
    
    // table view
    @IBOutlet var tableView: UITableView!
    let cellName = "cellName"
    let emptyCell = "emptyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup controller
        controller = QuestionsController(view: self)
        
        // steup objects
        setupObjects()
    }
    
    @IBAction func addAction(_ sender: Any) {
        controller.navigateToAddQuestion()
    }
    
    @IBAction func menuAction(_ sender: Any) {
        controller.navigateToOthers()
    }
    
    @IBAction func answerAction(_ sender: Any) {
        controller.navigateToAnswerQuestion()
    }
    
    @IBAction func behaviorAction(_ sender: Any) {
        controller.navigateToBehaviorView()
    }
    
    func reloadData() {
        tableView.reloadData()
        answerButton.isEnabled = controller.isAnswerButtonActivated()
    }
    
    func reloadLastAnswered () {
        lastAnsweredLabel.text = controller.getLastAnswered()
    }
    
    private func setupButton (button: UIButton) {        
        button.layer.cornerRadius = 25
        button.layer.shadowColor = ColorPicker.getButtonColors(.moss).cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    private func setupObjects () {
        // last answered string
        lastAnsweredLabel.text = controller.getLastAnswered()
        
        // add button
        setupButton(button: addButton)
        setupButton(button: answerButton)
        setupButton(button: behaviorButton)
        answerButton.isEnabled = controller.isAnswerButtonActivated()
        
        // table view
        tableView.register(QuestionCell.self, forCellReuseIdentifier: cellName)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: emptyCell)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
}

extension QuestionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.getNumberofQuestions()+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == controller.getNumberofQuestions() {
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath as IndexPath) as! EmptyCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath as IndexPath) as! QuestionCell
        
        let question = controller.getQuestionAtIndex(index: indexPath.row)
        let questionColor = ColorPicker.getColor(question.color)
        
        // edit cell
        cell.question.text = question.question
        cell.questionType.text = "Type: " + question.type.getTypeText()
        cell.coloredView.backgroundColor = questionColor
        cell.answeredLabel.text = "Answered " + String(question.timesAnswered) + " times"
        cell.averageLabel.text = controller.getStatsForQuestionAtIndex(index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == controller.getNumberofQuestions() { return 100 }
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.navigateToSingleQuestion(questionIndex: indexPath.row)
    }
}
