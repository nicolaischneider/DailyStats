//
//  AnswerVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 09.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController, AnswerViewControllerDelegate, AnswerDelegate {
    
    var controller: AnswerController!
        
    // objects
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quitButton: UIButton!
    
    // question view
    private let cellNameYesNo = "answerYesNoCell"
    private let cellnameScale1to5 = "answerScale1to5Cell"
    fileprivate let collectionView: UICollectionView = {
        // setup layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func quitAction(_ sender: Any) {
        controller.dismissVC()
    }
    
    func scale1to5QuestionWasAnsweredWith(res: Int, tag: Int) {
        print("answered with " + String(res))
        scrollToNextItem(tag: tag)
        controller.answeredQuestion(questionTag: tag, answer: res)
    }
    
    func yesQuestionWasAnsweredWithYes(res: Bool, tag: Int) {
        print("answered with " + String(res))
        scrollToNextItem(tag: tag)
        let res2 = (res) ? 0 : 1
        controller.answeredQuestion(questionTag: tag, answer: res2)
    }
    
    func scrollToNextItem(tag: Int) {
        if tag < controller.getNumOfQuestions()-1 {
            let indexPath = IndexPath(item: tag+1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }
    }
    
    private func setupObjects () {
        // collection view
        collectionView.register(YesNoAnswerCell.self, forCellWithReuseIdentifier: cellNameYesNo)
        collectionView.register(Scale1to5AnswerCell.self, forCellWithReuseIdentifier: cellnameScale1to5)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        // edit simple stuff
        titleLabel.isHidden = true
        view.bringSubviewToFront(quitButton)
    }
}

// setup collection view
extension AnswerVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.getNumOfQuestions()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let question = controller.getQuestionAtIndex(index: indexPath.item)
        
        switch question.type.getType() {
        
        // yes or no question
        case QuestionTypes.yesNo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNameYesNo, for: indexPath) as! YesNoAnswerCell
            cell.setupColor(color: question.color)
            cell.tag = indexPath.item
            cell.delegate = self
            cell.question.text = question.question
            return cell
            
        // question with scale of 1 to 5
        case QuestionTypes.scale1to5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellnameScale1to5, for: indexPath) as! Scale1to5AnswerCell
            cell.setupColor(color: question.color)
            cell.tag = indexPath.item
            cell.delegate = self
            cell.question.text = question.question
            return cell
        }
    }
}

