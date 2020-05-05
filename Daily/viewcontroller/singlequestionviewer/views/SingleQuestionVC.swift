//
//  SingleQuestionVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class SingleQuestionVC: UIViewController {
    
    var controller: SingleQuestionController!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    // buttons
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.backgroundColor = .clear
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // general information
    @IBOutlet weak var tableView: UITableView!
    let statsCell = "statsCell"
    let generalInfoCell = "generalInfoCell"
    let emptyCell = "emptyCell"
    
    var emptyCellIndex: Int!
    
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
    
    func reloadData () {
        tableView.reloadData()
    }
    
    private func setupTableView () {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(GeneralInfoCell.self, forCellReuseIdentifier: generalInfoCell)
        tableView.register(StatsCell.self, forCellReuseIdentifier: statsCell)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: emptyCell)
    }
    
    private func setupStackViewButtons () {
        for i in 0...2 {
            let buttonView = TimeButtonsView()
            let buttonProperty = controller.getButtonAtIndex(index: i)
            buttonView.setButtonTitle(titleString: buttonProperty!.0, active: buttonProperty!.1, timePeriod: buttonProperty!.2)
            buttonView.delegate = self
            stackView.addArrangedSubview(buttonView)
        }
    }
    
    private func setupObjects () {
        // setup textview
        questionTextView.isSelectable = false
        questionTextView.isEditable = false
        questionTextView.isScrollEnabled = false
        
        // setup question
        questionTextView.text = controller.getQuestion()
        let questionColor = controller.getQuestionColor()
        bgView.backgroundColor = ColorPicker.getColor(questionColor)
        
        // setup tableview witrh stats
        setupTableView()
        
        // setup button
        deleteButton.layer.cornerRadius = 15
        deleteButton.backgroundColor = ColorPicker.getButtonColors(.seashell)
        deleteButton.layer.shadowColor = ColorPicker.getButtonColors(.seashell).cgColor
        deleteButton.layer.shadowRadius = 10
        deleteButton.layer.shadowOpacity = 0.6
        deleteButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // setup stackview
        setupStackViewButtons()
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        stackView.isHidden = !controller.shouldShowStats()
    }
    
    var loadedOnce = false
}

extension SingleQuestionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if controller.shouldShowStats() {
            emptyCellIndex = 2
            return 3
        } else {
            emptyCellIndex = 1
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        // empty cell
        if indexPath.row == emptyCellIndex {
            loadedOnce = true
            let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath as IndexPath) as! EmptyCell
            return cell
        }
        
        // stats cell
        if indexPath.row == 0 && controller.shouldShowStats(){
            let cell = tableView.dequeueReusableCell(withIdentifier: statsCell, for: indexPath as IndexPath) as! StatsCell
            
            let answers = controller.getPossibleAnswers()
            let percentages = controller.getPercentagesString()
            let graphPerc = controller.getPercentagesFloat()
            let color = ColorPicker.getColor(controller.getQuestionColor())
            let behaviors = controller.getBehaviors()
            cell.setupObjects(ans: answers, percentages: percentages, graphPerc: graphPerc, color: color, behaviors: behaviors, frameWidth: view.frame.width)
            
            return cell
            
        // general info cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: generalInfoCell, for: indexPath as IndexPath) as! GeneralInfoCell
            
            let typeContent = controller.getStat(type: .type)
            let timesAnsweredContent = controller.getStat(type: .timesAnswered)
            let createdContent = controller.getStat(type: .dateOfCreation)
            
            cell.setupObjects(typeContent: typeContent, timesContent: timesAnsweredContent, createdContent: createdContent)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == emptyCellIndex {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
    
}

extension SingleQuestionVC: StatsTimePeriodDelegate {

    func changeStatsTimePeriod(to: StatsTimePeriod) {
        for view in stackView.arrangedSubviews as! [TimeButtonsView] {
            if view.statsTime == to {
                view.makeButtonActive(true)
            } else {
                view.makeButtonActive(false)
            }
        }
        
        controller.updateStatsTimePeriod(timePeriod: to)
    }

}
