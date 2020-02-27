//
//  SettingsController.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

class SettingsController {
    var view: SettingsVC!
    
    init(view: SettingsVC) {
        self.view = view
    }
    
    func updatedNotificationTimeTo (_ time: Date) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: time)
        dateComponents.minute = calendar.component(.minute, from: time)
        Notifications.changeScheduleOfNotification(time: dateComponents)
        view.reloadTimeString()
    }
    
    func isPushNotificationsActivated () -> Bool {
        return true
    }
    
    func openPrivacyPolicies () {
        print("open privacy policies")
    }
    
    func dismissVC () {
        view.dismiss(animated: true, completion: nil)
    }
}
