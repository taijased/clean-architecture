//
//  SystemEventsHandler.swift
//  clean-architecture
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit
import Swinject

public protocol SystemEventsHandlerInterface {
    //MARK: - Functions
    
    func openURLContexts(_ url: URL)
    
    func downloadedEvent(
        identifier: String,
        completionHandler: @escaping () -> Void
    )
}

public struct SystemEventsHandler: SystemEventsHandlerInterface {
    //MARK: - Properties
    
    private let container: Container
    
    private let deepLinksHandler: DeepLinksHandlerInterface
    
    private let pushNotificationsHandler: PushNotificationsHandlerInterface
    
    //MARK: - Initializer
    
    public init(
        container: Container,
        deepLinksHandler: DeepLinksHandlerInterface,
        pushNotificationsHandler: PushNotificationsHandlerInterface
    ) {
        self.container = container
        self.deepLinksHandler = deepLinksHandler
        self.pushNotificationsHandler = pushNotificationsHandler
    }
  
    //MARK: - Functions
    
    public func openURLContexts(_ url: URL) {
        guard let deepLink = DeepLink(url: url) else { return }
        deepLinksHandler.open(deepLink: deepLink)
    }
    
    public func downloadedEvent(
        identifier: String,
        completionHandler: @escaping () -> Void
    ) {
        pushNotificationsHandler.scheduleNotification(identifier: identifier)
        completionHandler()
    }
}
