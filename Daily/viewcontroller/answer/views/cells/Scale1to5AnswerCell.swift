//
//  Scale1to5AnswerCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 11.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class Scale1to5AnswerCell: UICollectionViewCell {
    let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .yellow
        view.layer.shadowColor = UIColor.red.cgColor
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
    
    private let cellName = "scaleButtonCell"
    fileprivate let collectionView: UICollectionView = {
        // setup layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var delegate: AnswerDelegate!
    private var selectedButton: Int!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        self.selectedButton = nil
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
    
    private func setupCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScaleButtonCell.self, forCellWithReuseIdentifier: cellName)
    }
    
    private func setupObjects () {
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
        
        // buttons
        setupCollectionView()
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        bringSubviewToFront(bgView)
    }
}

extension Scale1to5AnswerCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! ScaleButtonCell
        
        cell.number.text = String(indexPath.item+1)
        cell.bgView.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedButton = indexPath.item
        self.collectionView.reloadData()
        delegate.scale1to5QuestionWasAnsweredWith(res: indexPath.item, tag: tag)
    }
}
