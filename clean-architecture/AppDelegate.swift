//
//  AppDelegate.swift
//  clean-architecture
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import UIKit
import Infrastructure

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    
    private var rootCoordinator: BaseCoordinator?
    
    private var systemEventsHandler: SystemEventsHandler?
    
    // MARK: - Functions
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let environment: AppEnvironment = AppEnvironment.bootstrap()
        
        rootCoordinator = RootCoordinator(container: environment.container)
        rootCoordinator?.start()
        
        return true
    }
    
    // MARK: - Deeplink
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard
            userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL
        else {
            return false
        }
        
        systemEventsHandler?.openURLContexts(url)
        return true
    }
    
    // MARK: - Background URLSession
    
    func application(
        _ application: UIApplication,
        handleEventsForBackgroundURLSession identifier: String,
        completionHandler: @escaping () -> Void
    ) {
        systemEventsHandler?.downloadedEvent(
            identifier: identifier,
            completionHandler: completionHandler
        )
    }
}

