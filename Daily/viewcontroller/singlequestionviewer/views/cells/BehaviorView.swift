//
//  BehaviorView.swift
//  Daily
//
//  Created by Nicolai Schneider on 02.03.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class BehaviorView: UIView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let behaviorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        setupObjects()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContent (color: UIColor, text: String) {
        let convertedColor = color
        bgView.backgroundColor = convertedColor
        bgView.layer.shadowColor = convertedColor.cgColor
        behaviorLabel.text = text
    }
    
    private func setupObjects () {
        // bg view
        addSubview(bgView)
        bgView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        bgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        // label
        bgView.addSubview(behaviorLabel)
        behaviorLabel.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        behaviorLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 3).isActive = true
        behaviorLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -3).isActive = true
        behaviorLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
    }

}
