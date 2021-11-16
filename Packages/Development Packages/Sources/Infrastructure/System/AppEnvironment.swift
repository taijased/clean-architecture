//
//  AppEnvironment.swift
//  
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import Foundation
import Application
import Swinject

public struct AppEnvironment {
    //MARK: - Properties
    
    public let container: Container
    
    public let systemEventsHandler: SystemEventsHandler
    
    //MARK: - Functions
    
    public static func bootstrap() -> AppEnvironment {        
        let container = Container()
        configuredProduction(by: container)
        
        let deepLinksHandler = DeepLinksHandler(container: container)
        let pushNotificationsHandler = PushNotificationsHandler()
        let systemEventsHandler = SystemEventsHandler(
            container: container,
            deepLinksHandler: deepLinksHandler,
            pushNotificationsHandler: pushNotificationsHandler
        )
        
        return AppEnvironment(
            container: container,
            systemEventsHandler: systemEventsHandler
        )
    }
    
    private static func configuredProduction(by container: Container) {
        container.register(AppleMusicFacade.self) { r in
            let webRepository = AMWebRepository()
            let facade = AppleMusicFacade(webRepository: webRepository)
            return facade
        }
    }
    
    private static func configuredDevelopment(by container: Container) {
        container.register(AppleMusicFacade.self) { r in
            let webRepository = AMWebRepositoryFake()
            let facade = AppleMusicFacade(webRepository: webRepository)
            return facade
        }
    }
}

