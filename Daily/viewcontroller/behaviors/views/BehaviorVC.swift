//
//  BehaviorVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class BehaviorVC: UIViewController {
    
    var controller: BehaviorController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        controller.dismissVC()
    }
}
