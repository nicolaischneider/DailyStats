//
//  Behavior.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

struct Behavior: Codable {
    var id: UUID!
    var behavior: String!
    var color: Colors!
    
    init(behavior: String, color: Colors) {
        self.id = UUID()
        self.behavior = behavior
        self.color = color
    }
    
    public static func updateBehaviors (listOfBehaviors: [Behavior]) {
        let behaviorData = try! JSONEncoder().encode(listOfBehaviors)
        UserDefaults.standard.set(behaviorData, forKey: "userBehaviors")
    }
    
    public static func loadBehaviors() -> [Behavior]? {
        if let behaviorData = UserDefaults.standard.data(forKey: "userBehaviors") {
            let behaviorArray = try! JSONDecoder().decode([Behavior].self, from: behaviorData)
            return behaviorArray
        }
        return nil
    }
}
