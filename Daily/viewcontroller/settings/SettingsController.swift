//
//  SettingsController.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class SettingsController {
    var view: SettingsVC!
    
    init(view: SettingsVC) {
        self.view = view
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func willEnterForeground() {
        isPushNotificationsActivated()
    }
    
    func updatedNotificationTimeTo (_ time: Date) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: time)
        dateComponents.minute = calendar.component(.minute, from: time)
        Notifications.changeScheduleOfNotification(time: dateComponents)
        view.reloadTimeString()
    }
    
    func isPushNotificationsActivated () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] granted, error in
            print("Permission granted: \(granted)")
            guard granted else {
                self!.view.setupNotificationView(isActivated: false)
                return
            }
            self!.view.setupNotificationView(isActivated: granted)
        }
    }
    
    func openPrivacyPolicies () {
        print("open privacy policies")
    }
    
    func dismissVC () {
        view.dismiss(animated: true, completion: nil)
    }
}
