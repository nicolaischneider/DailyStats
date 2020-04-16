//
//  NewQuestionVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.01.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class NewQuestionVC: UIViewController, UITextViewDelegate {
    
    var controller: NewQuestionController!
    
    // question text field
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bgView: UIView!
    
    // titles
    @IBOutlet weak var title1: UILabel! // question
    @IBOutlet weak var title2: UILabel! // type
    @IBOutlet weak var title3: UILabel! // color picker
    
    // type buttons
    @IBOutlet weak var yesNoButton: UIButton!
    @IBOutlet weak var scaleButton: UIButton!
    @IBOutlet weak var addQuestionButton: UIButton!
    
    // color buttons
    private let cellName = "colorCell"
    fileprivate let collectionView: UICollectionView = {
        // setup layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        return collectionView
    }()
    
    // error
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func quitAction(_ sender: Any) {
        controller.dismissVC ()
    }
    
    @IBAction func yesNoAction(_ sender: Any) {
        selectButtonAction(isYesNo: true)
        controller.updateTypeOfQuestion(type: .yesNo)
    }
    
    @IBAction func scaleAction(_ sender: Any) {
        selectButtonAction(isYesNo: false)
        controller.updateTypeOfQuestion(type: .scale1to5)
    }
    
    private func selectButtonAction (isYesNo: Bool) {
        if isYesNo {
            setupButton(button: yesNoButton, color: Colors.seashell)
            setupButton(button: scaleButton, color: Colors.gray)
        } else {
            setupButton(button: yesNoButton, color: Colors.gray)
            setupButton(button: scaleButton, color: Colors.seashell)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .black
        if textView.text == "Enter here..." { textView.text = "" }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            dismissKeyboard()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let questionLength = textView.text.count
        if questionLength > 90 {
            textView.text.removeLast()
            return
        }
        controller.updateQuestion(question: textView.text)
    }
    
    func dismissKeyboard () {
        textView.resignFirstResponder()
        if textView.text == "" {
            textView.textColor = .darkGray
            textView.text = "Enter here..."
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    @IBAction func addQuestion(_ sender: Any) {
        controller.addQuestion()
    }
    
    func showError (error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
        
        // fade out
        UIView.animate(withDuration: 0.2, delay: 2.0, animations: {
            self.errorLabel.alpha = 0
        })
    }
    
    private func setupButton (button: UIButton, color: Colors) {
        button.backgroundColor = ColorPicker.getButtonColors(color)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = ColorPicker.getButtonColors(color).cgColor
        button.layer.shadowRadius = 15
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupCollectionView () {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: title3.bottomAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupObjects () {
        // setup buttons
        setupButton(button: yesNoButton, color: Colors.gray)
        setupButton(button: scaleButton, color: Colors.gray)
        setupButton(button: addQuestionButton, color: Colors.moss)
        
        // setup text field bg
        bgView.layer.cornerRadius = 10
        bgView.layer.shadowColor = UIColor(red: 163/255, green: 171/255, blue: 171/255, alpha: 1).cgColor
        bgView.layer.shadowRadius = 15
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // setup text field
        textView.text = "Enter here..."
        textView.delegate = self
        textView.textColor = .darkGray
        textView.keyboardDismissMode = .onDrag
        
        // tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // collection view
        setupCollectionView()
        
        // error label
        errorLabel.alpha = 0
    }
}

extension NewQuestionVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! ColorCell
        
        let color = controller.getColorForIndex(index: indexPath.item)

        if let selectedColor = controller.getSelectedColor() {
            if color == selectedColor { cell.selectCell() }
            else { cell.unSelectCell() }
        }
        
        cell.setupColor(color: color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = controller.getColorForIndex(index: indexPath.item)
        controller.updateColorOfQuestion(color: color)
        collectionView.reloadData()
    }
}
