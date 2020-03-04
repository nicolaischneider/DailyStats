//
//  StatsCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 20.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class GeneralInfoStackViewCell: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stat: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
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
    
    func setupContent (content: (String, String)) {
        titleLabel.text = content.0
        stat.text = content.1
    }

    private func setupObjects () {
        // title
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // stat
        addSubview(stat)
        stat.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        stat.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        stat.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        stat.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stat.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
