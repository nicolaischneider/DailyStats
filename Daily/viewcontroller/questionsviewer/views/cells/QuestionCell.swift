//
//  QuestionCell.swift
//  Daily
//
//  Created by Nicolai on 19.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coloredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let question: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let questionType: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answeredLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let averageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupObjects () {
        // shadow view
        addSubview(shadowView)
        shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 21).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor, constant: -21).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        
        // bg view
        addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        bgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        // colored view
        bgView.addSubview(coloredView)
        coloredView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 0).isActive = true
        coloredView.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 0).isActive = true
        coloredView.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: 0).isActive = true
        coloredView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // question
        bgView.addSubview(question)
        question.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 0).isActive = true
        question.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        question.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -30).isActive = true
        question.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // type
        bgView.addSubview(questionType)
        questionType.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 5).isActive = true
        questionType.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        questionType.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        questionType.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // answered
        bgView.addSubview(answeredLabel)
        answeredLabel.topAnchor.constraint(equalTo: questionType.bottomAnchor, constant: 0).isActive = true
        answeredLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        answeredLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        answeredLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // stats
        bgView.addSubview(averageLabel)
        averageLabel.topAnchor.constraint(equalTo: answeredLabel.bottomAnchor, constant: 0).isActive = true
        averageLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        averageLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        averageLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
