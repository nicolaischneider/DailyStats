//
//  ColorCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 29.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    let colorButton: UIView = {
        let button = UIView()
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectCell () {
        colorButton.layer.borderWidth = 2
        colorButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    func unSelectCell () {
        colorButton.layer.borderWidth = 0
    }
    
    func setupColor (color: Colors) {
        let convertedColor = ColorPicker.getColor(color)
        colorButton.backgroundColor = convertedColor
        colorButton.layer.shadowColor = convertedColor.cgColor
    }
    
    private func setupObjects () {
        contentView.addSubview(colorButton)
        colorButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        colorButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        colorButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        colorButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
}
