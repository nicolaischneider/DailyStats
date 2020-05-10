//
//  TutorialVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 06.05.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
    
    var controller: TutorialController!
    
    // objects
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    // content
    private let cellName = "tutorialCell"
    fileprivate let collectionView: UICollectionView = {
        // setup layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func quitAction(_ sender: Any) {
        controller.dismissVC()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        controller.nextTutorialSlide()
    }
    
    func scrollToPage (_ page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        setupNextButton(forPage: page)
    }
    
    private func setupNextButton (forPage page: Int) {
        if page == controller.getNumberOfSlides()-1 {
            nextButton.backgroundColor = ColorPicker.getButtonColors(.seashell)
            nextButton.layer.shadowColor = ColorPicker.getButtonColors(.seashell).cgColor
            nextButton.setTitle("Done", for: .normal)
        } else {
            nextButton.backgroundColor = ColorPicker.getButtonColors(.moss)
            nextButton.layer.shadowColor = ColorPicker.getButtonColors(.moss).cgColor
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    private func setupObjects () {
        // setup view
        bgView.layer.cornerRadius = 10
        bgView.clipsToBounds = true
        
        // setup next button (color, corner radius, shadow)
        nextButton.backgroundColor = ColorPicker.getButtonColors(.moss)
        nextButton.layer.cornerRadius = 10
        nextButton.layer.shadowRadius = 10
        nextButton.layer.shadowOpacity = 0.7
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        nextButton.layer.shadowColor = ColorPicker.getButtonColors(.moss).cgColor
        
        // setup collection view
        collectionView.register(TutorialCell.self, forCellWithReuseIdentifier: cellName)
        bgView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: quitButton.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: bgView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 5).isActive = true
        
        // bring subviews to front
        view.bringSubviewToFront(collectionView)
        view.bringSubviewToFront(quitButton)
        view.bringSubviewToFront(nextButton)
    }
}

extension TutorialVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.getNumberOfSlides()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! TutorialCell
        let content = controller.getContent(atIndex: indexPath.item)
        cell.setupContent(text: content.1, img: content.0)
        return cell
    }
    

}
