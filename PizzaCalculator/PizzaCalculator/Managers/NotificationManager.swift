//
//  NotificationManager.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    static func requestPermission(_ didFail: @escaping ((Error) -> Void)) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { success, error in
            if success {
                print("Success")
            } else if let error {
                didFail(error)
            }
        }
    }
    
    static func scheduleNotification(title: String, message: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = message
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    static func cancelNotifications() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
