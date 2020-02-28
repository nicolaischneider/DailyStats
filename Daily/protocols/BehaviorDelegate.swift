//
//  BehaviorDelegate.swift
//  Daily
//
//  Created by Nicolai Schneider on 28.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

protocol BehaviorDelegate {
    func getListOfBehaviors () -> [Behavior]
    func addBehavior (behavior: Behavior)
    func updateBehavior (behavior: Behavior)
    func deleteBehavior (behaviorID: UUID)
}
