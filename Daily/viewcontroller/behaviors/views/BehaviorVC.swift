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
        
        // setup collectionview
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: titleLabell.bottomAnchor, constant: 15).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
