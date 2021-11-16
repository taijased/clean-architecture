//
//  SystemEventsHandler.swift
//  clean-architecture
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit
import Swinject

public protocol ISystemEventsHandler {
    //MARK: - Functions
    
    func openURLContexts(_ url: URL)
    
    func downloadedEvent(
        identifier: String,
        completionHandler: @escaping () -> Void
    )
}

public struct SystemEventsHandler: ISystemEventsHandler {
    //MARK: - Properties
    
    private let container: Container
    
    private let deepLinksHandler: IDeepLinksHandler
    
    private let pushNotificationsHandler: IPushNotificationsHandler
    
    //MARK: - Initializer
    
    public init(
        container: Container,
        deepLinksHandler: IDeepLinksHandler,
        pushNotificationsHandler: IPushNotificationsHandler
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
