//
//  NotificationTime.swift
//  Daily
//
//  Created by Nicolai Schneider on 25.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import Foundation

struct NotificationTime: Codable {
    var hour: Int!
    var minute: Int!
    
    init(hour: Int, min: Int) {
        self.hour = hour
        self.minute = min
    }
    
    public static func updateNotification (time: NotificationTime) {
        let notificationData = try! JSONEncoder().encode(time)
        UserDefaults.standard.set(notificationData, forKey: "notificationTime")
    }
    
    public static func loadNotification() -> NotificationTime? {
        if let _data = UserDefaults.standard.data(forKey: "notificationTime") {
            let notification = try! JSONDecoder().decode(NotificationTime.self, from: _data)
            return notification
        }
        return nil
    }
}
