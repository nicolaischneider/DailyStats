//
//  ListOfBehaviorsCell.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class ListOfBehaviorsCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let doneButton: ButtonPress = {
        let button = ButtonPress()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 15
        button.backgroundColor = ColorPicker.getButtonColors(.moss)
        button.layer.shadowColor = ColorPicker.getButtonColors(.moss).cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // collection view
    let cellName = "cellName"
    fileprivate let collectionView: UICollectionView = {
        // setup layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(BehaviorCell.self, forCellWithReuseIdentifier: "cellName")
        return collectionView
    }()
    
    let hideView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noBehaviorsAvailable: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var behaviorDelegate: BehaviorDelegate!
    var answerDelegate: AnswerDelegate!
    
    var listOfBehaviors: [Behavior]!
    var selectedItems = [Bool]()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupObjects()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneAction () {
        answerDelegate.addBehaviors(selectedBehaviors: selectedItems)
    }
    
    private func setupViewsToShow () {
        // setup views to show/hide
        if listOfBehaviors.count > 0 {
            noBehaviorsAvailable.isHidden = true
        } else {
            titleLabel.isHidden = true
            collectionView.isHidden = true
        }
    }
    
    private func getBehaviors () {
        listOfBehaviors = behaviorDelegate.getListOfBehaviors()
        for _ in 0..<listOfBehaviors.count {
            selectedItems.append(false)
        }
        setupViewsToShow()
    }
    
    private func setupObjects () {
        // bg view
        addSubview(hideView)
        hideView.topAnchor.constraint(equalTo: topAnchor, constant: -70).isActive = true
        hideView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        hideView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        hideView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        // title
        hideView.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: hideView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.text = "Select your behaviors of the day."
        
        // setup collections view
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // done button
        addSubview(doneButton)
        doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        
        // no behaviors available
        addSubview(noBehaviorsAvailable)
        noBehaviorsAvailable.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        noBehaviorsAvailable.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        noBehaviorsAvailable.heightAnchor.constraint(equalToConstant: 150).isActive = true
        noBehaviorsAvailable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        noBehaviorsAvailable.text = "You haven't added any Behaviors yet."
        
        // set views to front
        bringSubviewToFront(hideView)
    }
}

extension ListOfBehaviorsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.frame.width/3
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = listOfBehaviors {
            return list.count
        } else {
            getBehaviors()
            return listOfBehaviors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let list = delegate.getListOfBehaviors()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! BehaviorCell
        let behavior = listOfBehaviors[indexPath.item]
        cell.behaviorLabel.text = behavior.behavior
        
        if selectedItems[indexPath.item] {
            cell.setupColor(color: behavior.color)
        } else {
            cell.setupColor(color: .lightGray)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItems[indexPath.item] = !selectedItems[indexPath.item]
        collectionView.reloadData()
    }

}
