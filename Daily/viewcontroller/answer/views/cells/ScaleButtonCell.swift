//
//  ScaleButtonCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 12.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class ScaleButtonCell: CollectionViewCellPress {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let number: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
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
    
    private func setupObjects () {
        addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        bgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        addSubview(number)
        number.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        number.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        number.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        number.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
}
