//
//  AddBehaviorController.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class AddBehaviorController {
    
    var view: AddBehaviorVC!
    var delegate: BehaviorDelegate!
    
    // created behavior
    private var behaviorText: String?
    private var behaviorColor: Colors?
    
    var editMode: Bool!
    private var behaviorToEdit: Behavior?
    
    init(view: AddBehaviorVC, behavior: Behavior?) {
        self.view = view
        self.behaviorColor = getColorForIndex(index: 0)
        editMode = false
        
        // is edit mode ?
        if let _behavior = behavior {
            editMode = true
            behaviorToEdit = _behavior
            behaviorText = _behavior.behavior
            behaviorColor = _behavior.color
        }
    }
    
    func isEditMode () -> Bool {
        return editMode
    }
    
    func getBehaviorData () -> (String, UIColor) {
        let color = ColorPicker.getColor(behaviorColor!)
        return (behaviorText!, color)
    }
    
    func updateColorOfBehavior(color: Colors) {
        self.behaviorColor = color
        let bgColor = ColorPicker.getColor(color)
        view.reloadViewData(color: bgColor)
    }
    
    func getSelectedColor() -> Colors? {
        return behaviorColor
    }
    
    func getColorForIndex(index: Int) -> Colors {
        switch index {
            case 0: return .lambsGreen
            case 1: return .costalBlue
            case 2: return .desertSand
            case 3: return .coral
            case 4: return .terracotta
            default: return .defaultCol
        }
    }
    
    func updateBehaviorText (text: String) {
        behaviorText = text
        view.changeBehaviorText(text: text)
    }
    
    func addBehavior () {
        guard let _ = behaviorText else {
            print("text missing")
            return
        }
        
        if behaviorText == "" { return }
        
        guard let _ = behaviorColor else {
            print("color missing")
            return
        }
        
        if editMode {
            behaviorToEdit?.behavior = behaviorText
            behaviorToEdit?.color = behaviorColor
            delegate.updateBehavior(behavior: behaviorToEdit!)
        } else {
            let behavior = Behavior(behavior: behaviorText!, color: behaviorColor!)
            delegate.addBehavior(behavior: behavior)
        }
        dismissVC()
    }
    
    func deleteBehavior () {
        if editMode {
            delegate.deleteBehavior(behaviorID: behaviorToEdit!.id)
            dismissVC()
        }
    }
    
    func dismissVC () {
        view.dismiss(animated: true, completion: nil)
    }
}
