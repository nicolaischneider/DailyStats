//
//  BehaviorController.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

class BehaviorController {
    
    var view: BehaviorVC!
    
    init(view: BehaviorVC) {
        self.view = view
    }
    
    func dismissVC () {
        view.dismiss(animated: true, completion: nil)
    }
}
