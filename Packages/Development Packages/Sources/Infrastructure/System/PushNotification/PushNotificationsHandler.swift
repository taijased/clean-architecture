//
//  PushNotificationsHandler.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit

public protocol PushNotificationsHandlerInterface {
    //MARK: - Functions
    
    func requestAutorization()
    
    func scheduleNotification(identifier: String)
}

public final class PushNotificationsHandler: NSObject, PushNotificationsHandlerInterface {
    //MARK: - Properties
    
    public let notificationCenter = UNUserNotificationCenter.current()
    
    //MARK: - Initializer
    
    public override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    //MARK: - Functions
    
    public func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
        }
    }
    
    public func scheduleNotification(identifier: String) {
        let content = UNMutableNotificationContent()
        
        content.title = "Example local notify"
        content.body = "Tap to open"
        content.sound = .default
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        content.categoryIdentifier = identifier
        content.summaryArgument = identifier
        content.summaryArgumentCount = 10
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let identifire = UUID().uuidString
        let request = UNNotificationRequest(
            identifier: identifire,
            content: content,
            trigger: trigger
        )
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
