//
//  ButtonPressEffect.swift
//  100Questions
//
//  Created by Nicolai on 26.07.17.
//  Copyright © 2017 Schneider & co. All rights reserved.
//

import UIKit

class ButtonPress: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity // reset size to default
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }
}
