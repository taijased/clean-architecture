//
//  PushNotificationsHandler+UNUserNotificationCenterDelegate.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit

extension PushNotificationsHandler: UNUserNotificationCenterDelegate {
    //MARK: - Funcitons
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.list, .sound])
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let identifier = response.notification.request.content.categoryIdentifier
        handleNotification(categoryIdentifier: identifier, completionHandler: completionHandler)
    }
    
    public func handleNotification(
        categoryIdentifier: String,
        completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
}
