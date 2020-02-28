//
//  BehaviorCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class BehaviorCell: UICollectionViewCell {
    
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
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        bgView.backgroundColor = convertedColor
        bgView.layer.shadowColor = convertedColor.cgColor
    }

    private func setupObjects () {
        // add bg view
        addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        bgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        // add behavior title
        bgView.addSubview(behaviorLabel)
        behaviorLabel.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        behaviorLabel.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 10).isActive = true
        behaviorLabel.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -10).isActive = true
        behaviorLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 0).isActive = true
    }
}
