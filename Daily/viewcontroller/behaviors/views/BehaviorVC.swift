//
//  BehaviorVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class BehaviorVC: UIViewController {
    
    var controller: BehaviorController!

    // objects
    @IBOutlet weak var titleLabell: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var noBehaviorsLabel: UILabel!
    @IBOutlet weak var quitButton: UIButton!
    
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
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        controller.dismissVC()
    }
    
    @IBAction func addBehaviorAction(_ sender: Any) {
        controller.navigateToAddBehavior()
    }
    
    func reloadData () {
        collectionView.reloadData()
        noBehaviorsLabel.isHidden = controller.areBehaviorsAvailable()
    }
    
    private func setupObjects () {
        // setup buttons
        plusButton.layer.cornerRadius = 20
        noBehaviorsLabel.isHidden = controller.areBehaviorsAvailable()
        
        // bg view
        view.addSubview(hideView)
        hideView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
        hideView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        hideView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        hideView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        // setup collectionview
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: titleLabell.bottomAnchor, constant: 15).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // views to front
        view.bringSubviewToFront(hideView)
        view.bringSubviewToFront(quitButton)
        view.bringSubviewToFront(plusButton)
        view.bringSubviewToFront(titleLabell)
    }
}

extension BehaviorVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.frame.width/3
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.getNumOfBehaviors()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! BehaviorCell
        let behavior = controller.getBehaviorAtIndex(index: indexPath.item)
        cell.behaviorLabel.text = behavior.behavior
        cell.setupColor(color: behavior.color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller.navigateToEditBehavior(behaviorIndex: indexPath.item)
    }
}
