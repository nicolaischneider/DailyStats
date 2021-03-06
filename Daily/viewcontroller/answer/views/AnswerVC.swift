//
//  AnswerVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 09.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController {
    
    var controller: AnswerController!
        
    // objects
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    
    // question view
    private let cellNameYesNo = "answerYesNoCell"
    private let cellnameScale1to5 = "answerScale1to5Cell"
    private let cellNameBehaviors = "behaviorCell"
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
        controller.closeAction()
    }
    
    @IBAction func skipAction(_ sender: Any) {
        controller.skipQuestion()
    }
    
    func scrollToNextItem(tag: Int) {
        if tag < controller.getNumOfQuestions() {
            let indexPath = IndexPath(item: tag+1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }
        if tag+2 > controller.getNumOfQuestions() {
            questionNumber.isHidden = true
            skipButton.isHidden = true
        } else {
            questionNumber.text = String(tag+2)+"/"+String(controller.getNumOfQuestions())
        }
    }
    
    private func setupObjects () {
        // collection view
        collectionView.register(YesNoAnswerCell.self, forCellWithReuseIdentifier: cellNameYesNo)
        collectionView.register(Scale1to5AnswerCell.self, forCellWithReuseIdentifier: cellnameScale1to5)
        collectionView.register(ListOfBehaviorsCell.self, forCellWithReuseIdentifier: cellNameBehaviors)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        // edit objects
        titleLabel.isHidden = true
        questionNumber.text = "1/"+String(controller.getNumOfQuestions())
        
        // skip button
        skipButton.layer.cornerRadius = 15
        skipButton.backgroundColor = ColorPicker.getButtonColors(.moss)
        skipButton.layer.shadowColor = ColorPicker.getButtonColors(.moss).cgColor
        skipButton.layer.shadowRadius = 10
        skipButton.layer.shadowOpacity = 0.6
        skipButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // bring views to front
        view.bringSubviewToFront(questionNumber)
        view.bringSubviewToFront(quitButton)
        view.bringSubviewToFront(skipButton)
    }
}

// setup collection view
extension AnswerVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.getNumOfQuestions()+1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // last page: behaviors
        if indexPath.item == controller.getNumOfQuestions() {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNameBehaviors, for: indexPath) as! ListOfBehaviorsCell
            cell.behaviorDelegate = controller.getDelegate()
            cell.answerDelegate = self
            return cell
        }
        
        let question = controller.getQuestionAtIndex(index: indexPath.item)
        
        switch question.type {
        
        // yes or no question
        case .yesNo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNameYesNo, for: indexPath) as! YesNoAnswerCell
            cell.setupColor(color: question.color)
            cell.tag = indexPath.item
            cell.delegate = self
            cell.question.text = question.question
            return cell
            
        // question with scale of 1 to 5
        case .scale1to5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellnameScale1to5, for: indexPath) as! Scale1to5AnswerCell
            cell.setupColor(color: question.color)
            cell.tag = indexPath.item
            cell.delegate = self
            cell.question.text = question.question
            return cell
        
        case .none:
            print("error: trying to return a non existing cell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNameYesNo, for: indexPath) as! YesNoAnswerCell
            return cell
        }
    }
}

extension AnswerVC: AnswerDelegate {
    func scale1to5QuestionWasAnsweredWith(res: Int, tag: Int) {
        scrollToNextItem(tag: tag)
        controller.answeredQuestion(questionTag: tag, answer: res)
    }
    
    func yesQuestionWasAnsweredWithYes(res: Bool, tag: Int) {
        scrollToNextItem(tag: tag)
        let res2 = (res) ? 0 : 1
        controller.answeredQuestion(questionTag: tag, answer: res2)
    }
    
    func addBehaviors(selectedBehaviors: [Bool]) {
        controller.addBhevaviors(selectedBehaviors: selectedBehaviors)
    }
}

