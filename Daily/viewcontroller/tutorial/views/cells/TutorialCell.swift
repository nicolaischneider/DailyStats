//
//  TutorialCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 06.05.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell {
    
    let icon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    func setupContent (text: String, img: UIImage) {
        self.icon.image = img
        self.desc.text = text
    }
    
    private func setupObjects () {
        // add icon
        addSubview(icon)
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 150).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        // add text
        addSubview(desc)
        desc.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 20).isActive = true
        desc.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        desc.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        desc.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
    }
    
}
