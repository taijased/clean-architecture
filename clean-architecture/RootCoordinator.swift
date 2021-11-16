//
//  RootCoordinator.swift
//  
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import UIKit
import Swinject
import Infrastructure
import AppleMusic

public final class RootCoordinator: BaseCoordinator {
    // MARK: - Properties
    
    private lazy var window = UIWindow(frame: UIScreen.main.bounds)
    
    private lazy var rootVC = UIViewController()
    
    private let container: Container
    
    // MARK: - Initializer
    
    public init(container: Container) {
        self.container = container
    }
    
    // MARK: - Functions
    
    public override func start() {
        super.start()
        
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        coordinateHome()
    }
    

    private func coordinateHome() {
        let coordinatorApple = AppleMusicCoordinator(
            container: container,
            parent: rootVC
        )
        coordinate(to: coordinatorApple)
    }
}

