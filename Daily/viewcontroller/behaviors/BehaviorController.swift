//
//  BehaviorController.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit

class BehaviorController {
    
    var view: BehaviorVC!
    var delegate: BehaviorDelegate!
        
    init(view: BehaviorVC) {
        self.view = view
    }
    
    func areBehaviorsAvailable () -> Bool {
        if getNumOfBehaviors() > 0 { return true }
        else { return false }
    }
    
    func getNumOfBehaviors () -> Int {
        let list = getListOfBehaviors()
        return list.count
    }
    
    func getBehaviorAtIndex (index: Int) -> Behavior {
        let list = getListOfBehaviors()
        return list[index]
    }
    
    func navigateToAddBehavior () {
        navigateToAddEditBehavior(behavior: nil)
    }
    
    func navigateToEditBehavior (behaviorIndex: Int) {
        let list = getListOfBehaviors()
        let behavior = list[behaviorIndex]
        navigateToAddEditBehavior(behavior: behavior)
    }
    
    private func navigateToAddEditBehavior (behavior: Behavior?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let addBehaviorController = storyBoard.instantiateViewController(withIdentifier: "AddBehaviorViewController") as! AddBehaviorVC
        addBehaviorController.controller = AddBehaviorController(view: addBehaviorController, behavior: behavior)
        addBehaviorController.controller.delegate = self
        view.present(addBehaviorController, animated:true, completion:nil)
    }
    
    func dismissVC () {
        view.dismiss(animated: true, completion: nil)
    }
}

extension BehaviorController: BehaviorDelegate {
    func addBehavior(behavior: Behavior) {
        delegate.addBehavior(behavior: behavior)
        view.reloadData()
    }
    
    func updateBehavior(behavior: Behavior) {
        delegate.updateBehavior(behavior: behavior)
        view.reloadData()
    }
    
    func deleteBehavior(behaviorID: UUID) {
        delegate.deleteBehavior(behaviorID: behaviorID)
        view.reloadData()
    }
    
    func getListOfBehaviors() -> [Behavior] {
        delegate.getListOfBehaviors()
    }
}
