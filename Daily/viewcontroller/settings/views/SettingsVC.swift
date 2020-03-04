//
//  SettingsVC.swift
//  Daily
//
//  Created by Nicolai Schneider on 27.02.20.
//  Copyright © 2020 kncproductions. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var controller: SettingsController!
    
    // objects main view
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var timeOfNots: UILabel!
    
    // push notifications subview
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var pushNotTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObjects()
    }
    
    @IBAction func activateNotificationsAction(_ sender: Any) {
    }
    
    @IBAction func openPrivacyPolicies(_ sender: Any) {
        controller.openPrivacyPolicies()
    }
    
    @IBAction func quitButton(_ sender: Any) {
        controller.dismissVC()
    }
    
    func reloadTimeString () {
        let storedTime = Notifications.getNotificationTime()
        let hourString = "\(storedTime.hour!)"
        var minuteString = "\(storedTime.minute!)"
        if storedTime.minute! < 10 {
            minuteString = "0\(storedTime.minute!)"
        }
        timeOfNots.text = hourString + ":" + minuteString + "h"
    }
    
    @objc func datePickerValueChanged (_ sender: UIDatePicker) {
        controller.updatedNotificationTimeTo(datePicker.date)
    }
    
    func setupNotificationView (isActivated: Bool) {
        DispatchQueue.main.async {
            self.notificationLabel.isHidden = isActivated
            self.timeOfNots.isHidden = !isActivated
            self.pushNotTitleLabel.isHidden = !isActivated
            self.datePicker.isHidden = !isActivated
        }
    }
    
    private func setupObjects () {
        // corner radius
        bgView.layer.cornerRadius = 20
        subView.layer.cornerRadius = 10
        
        // set alpha values
        controller.isPushNotificationsActivated()
        
        // setup date picker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // set time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let storedTime = Notifications.getNotificationTime()
        let timeString = "\(storedTime.hour!):\(storedTime.minute!)"
        let date = dateFormatter.date(from: timeString)
        datePicker.date = date!
        reloadTimeString()
    }
    
}
