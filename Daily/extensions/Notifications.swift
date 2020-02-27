//
//  Notifications.swift
//  Daily
//
//  Created by Nicolai Schneider on 25.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications: NSObject {
    
    private static var notificationsAllowed: Bool!
    
    static let center = UNUserNotificationCenter.current()
    
    static func isPushNotAllowed () -> Bool {
        return notificationsAllowed
    }
    
    static func setNotificationsAllowedTo(_ isAllowed: Bool) {
        self.notificationsAllowed = isAllowed
    }
    
    static var content: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "It's time to answer your Daily Questions"
        content.body = "Take 30 seconds to answer your questions and update your Daily Stats"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["data":"input"]
        content.sound = .default
        return content
    }()
    
    static func scheduleNotifications () {
        center.removeAllPendingNotificationRequests()
        // set time
        let dateComponents = getNotificationTime()
        // trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: self.content, trigger: trigger)
        center.add(request)
        print("Notification time is set to \(dateComponents.hour!)h \(dateComponents.minute!)min")
    }
    
    static func changeScheduleOfNotification (time: DateComponents) {
        saveNotificationTime(time: time)
        center.removeAllPendingNotificationRequests()
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: self.content, trigger: trigger)
        center.add(request)
        print("Notification time is updated to \(time.hour!)h \(time.minute!)min")
    }
    
    private static func saveNotificationTime(time: DateComponents) {
        let notificationTime = NotificationTime(hour: time.hour!, min: time.minute!)
        NotificationTime.updateNotification(time: notificationTime)
    }
    
    static func getNotificationTime () -> DateComponents {
        if let notificationTime = NotificationTime.loadNotification() {
            var dateComponents = DateComponents()
            dateComponents.hour = notificationTime.hour
            dateComponents.minute = notificationTime.minute
            return dateComponents
        } else {
            // case: no time for notifiations was set yet, set time to 9pm
            var standardDateComponents = DateComponents()
            standardDateComponents.hour = 21
            standardDateComponents.minute = 0
            return standardDateComponents
        }
    }
}
