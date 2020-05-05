//
//  GeneralInfoCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 01.03.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class GeneralInfoCell: UITableViewCell {
    
    lazy var leftStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.backgroundColor = .clear
        sv.axis = .vertical
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var rightStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.backgroundColor = .clear
        sv.axis = .vertical
        sv.spacing = 15
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
    
    private func resetStackView (stackView: UIStackView) {
        for view in stackView.arrangedSubviews {
            view.isHidden = true
            stackView.removeArrangedSubview(view)
        }
    }
    
    private func addCellsToStackViews (typeContent: (String,String), timesContent: (String,String), createdContent: (String,String)) {
        // type
        let typeCell = GeneralInfoStackViewCell()
        typeCell.setupContent(content: (typeContent.0, typeContent.1))
        leftStackView.addArrangedSubview(typeCell)
        
        // times
        let timesAnswered = GeneralInfoStackViewCell()
        timesAnswered.setupContent(content: (timesContent.0, timesContent.1))
        leftStackView.addArrangedSubview(timesAnswered)
        
        // created
        let createdCell = GeneralInfoStackViewCell()
        createdCell.setupContent(content: (createdContent.0, createdContent.1))
        rightStackView.addArrangedSubview(createdCell)
    }
    
    func setupObjects (typeContent: (String,String), timesContent: (String,String), createdContent: (String,String)) {
        // get stackviews ready
        if leftStackView.arrangedSubviews.count > 0 {
            resetStackView(stackView: leftStackView)
        }
        if rightStackView.arrangedSubviews.count > 0 {
            resetStackView(stackView: rightStackView)
        }
        addCellsToStackViews(typeContent: typeContent, timesContent: timesContent, createdContent: createdContent)
        
        // add left stackview to cell
        addSubview(leftStackView)
        leftStackView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        leftStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
        leftStackView.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
        leftStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // add right stackview
        addSubview(rightStackView)
        rightStackView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        rightStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        rightStackView.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
    }
    
}
