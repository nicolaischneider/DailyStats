//
//  AnswerCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 11.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class YesNoAnswerCell: UICollectionViewCell {
    
    let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let question: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yesButton: ButtonPress = {
        let button = ButtonPress()
        button.setTitle("Yes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 142/255, green: 186/255, blue: 168/255, alpha: 1.0)
        button.layer.shadowColor = UIColor(red: 142/255, green: 186/255, blue: 168/255, alpha: 1.0).cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let noButton: ButtonPress = {
        let button = ButtonPress()
        button.setTitle("No", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 227/255, green: 130/255, blue: 81/255, alpha: 1.0)
        button.layer.shadowColor = UIColor(red: 227/255, green: 130/255, blue: 81/255, alpha: 1.0).cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: AnswerDelegate!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupObjects()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupColor (color: Colors) {
        let convertedColor = ColorPicker.getColor(color)
        bgView.layer.shadowColor = convertedColor.cgColor
        bgView.backgroundColor = convertedColor
    }
    
    private func setupButtons () {
        yesButton.addTarget(self, action: #selector(selectedYesButton), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(selectedNoButton), for: .touchUpInside)
    }
    
    @objc func selectedYesButton () {
        delegate.yesQuestionWasAnsweredWithYes(res: true, tag: tag)
    }
    
    @objc func selectedNoButton () {
        delegate.yesQuestionWasAnsweredWithYes(res: false, tag: tag)
    }
    
    private func setupObjects () {
        setupButtons()
        
        // background view
        addSubview(bgView)
        bgView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
        bgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        bgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // background view
        bgView.addSubview(question)
        question.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        question.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        question.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        question.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
        
        // yes button
        addSubview(yesButton)
        yesButton.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20).isActive = true
        yesButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        yesButton.widthAnchor.constraint(equalTo: bgView.widthAnchor, multiplier: 1/2.1).isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // no button
        addSubview(noButton)
        noButton.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 20).isActive = true
        noButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        noButton.widthAnchor.constraint(equalTo: bgView.widthAnchor, multiplier: 1/2.1).isActive = true
        noButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}
