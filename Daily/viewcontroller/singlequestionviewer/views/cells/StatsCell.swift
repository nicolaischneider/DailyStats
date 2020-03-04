//
//  StatsCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 01.03.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.backgroundColor = .clear
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addCellsToStackView (ans: [String], percentages: [String], graphPerc: [Float], color: UIColor, behaviors: [[Behavior?]]) {
        
        for i in 0..<ans.count {
            let answerCell = StatsStackViewCell()
            answerCell.setupObjects(ans: ans[i], perc: percentages[i], graphWidth: Float(frame.width/3)*graphPerc[i], color: color, behaviors: behaviors[i])
            stackView.addArrangedSubview(answerCell)
        }
    }
    
    func setupObjects (ans: [String], percentages: [String], graphPerc: [Float], color: UIColor, behaviors: [[Behavior?]]) {
        // get stack view ready with stats
        addCellsToStackView(ans: ans, percentages: percentages, graphPerc: graphPerc, color: color, behaviors: behaviors)
        
        // add stackview
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
