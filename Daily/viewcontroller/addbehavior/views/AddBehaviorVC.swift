//
//  AddBehaviorVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class AddBehaviorVC: UIViewController, UITextFieldDelegate {
    
    var controller: AddBehaviorController!
    
    // objects
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var behaviorLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addBehaviorButton: UIButton!
    @IBOutlet weak var deleteBehaviorButton: UIButton!
    
    // color buttons
    private let cellName = "colorCell"
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
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func addBehaviorAction(_ sender: Any) {
        controller.addBehavior()
    }
    
    @IBAction func deleteBehavior(_ sender: Any) {
        print("hi")
        controller.deleteBehavior()
    }
    
    @IBAction func quitAction(_ sender: Any) {
        controller.dismissVC()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        // case: empty
        if text == "" { return }
        
        // case: too long
        if text.count > 15 {
            self.textField.text?.removeLast()
            return
        }
        controller.updateBehaviorText(text: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func changeBehaviorText (text: String) {
        behaviorLabel.text = text
    }
    
    // only for edit mode
    func insertBehavior (text: String, color: UIColor) {
        behaviorLabel.text = text
        textField.text = text
        bgView.backgroundColor = color
        bgView.layer.shadowColor = color.cgColor
        
        // change to edit mode
        deleteBehaviorButton.isHidden = false
        view.bringSubviewToFront(deleteBehaviorButton)
        addBehaviorButton.setTitle("Update Behavior", for: .normal)
    }
    
    func reloadViewData (color: UIColor) {
        collectionView.reloadData()
        bgView.backgroundColor = color
        bgView.layer.shadowColor = color.cgColor
    }
    
    private func setupObjects () {
        // collection view
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: addBehaviorButton.topAnchor, constant: -20).isActive = true
        
        // behavior symbol
        bgView.layer.cornerRadius = 10
        let bgColor = ColorPicker.getColor(controller.getSelectedColor()!)
        bgView.backgroundColor = bgColor
        bgView.layer.shadowRadius = 10
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowColor = bgColor.cgColor
        
        // textfield
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.becomeFirstResponder()
        
        // add behavior button
        addBehaviorButton.backgroundColor = ColorPicker.getButtonColors(.moss)
        addBehaviorButton.layer.cornerRadius = 10
        addBehaviorButton.layer.shadowRadius = 10
        addBehaviorButton.layer.shadowOpacity = 0.7
        addBehaviorButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addBehaviorButton.layer.shadowColor = ColorPicker.getButtonColors(.moss).cgColor
        
        // tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // insets
        deleteBehaviorButton.layer.cornerRadius = 15
        deleteBehaviorButton.backgroundColor = ColorPicker.getButtonColors(.seashell)
        deleteBehaviorButton.layer.shadowColor = ColorPicker.getButtonColors(.seashell).cgColor
        deleteBehaviorButton.layer.shadowRadius = 10
        deleteBehaviorButton.layer.shadowOpacity = 0.6
        deleteBehaviorButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        deleteBehaviorButton.isHidden = true
        if controller.isEditMode() {
            let behaviorData = controller.getBehaviorData()
            insertBehavior(text: behaviorData.0, color: behaviorData.1)
        }
    }
}

extension AddBehaviorVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
        controller.updateColorOfBehavior(color: color)
    }
}
