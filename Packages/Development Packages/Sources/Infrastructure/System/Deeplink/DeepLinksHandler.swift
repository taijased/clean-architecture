//
//  DeepLinksHandler.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation
import Swinject

public protocol DeepLinksHandlerInterface {
    //MARK: - Functions
    
    func open(deepLink: DeepLink)
}

public struct DeepLinksHandler: DeepLinksHandlerInterface {
    //MARK: - Properties
    
    private let container: Container
    
    //MARK: - Initializer
    
    public init(container: Container) {
        self.container = container
    }
    
    //MARK: - Functions
    
    public func open(deepLink: DeepLink) {
        switch deepLink {
        case .appleMusic(let id):
            print(id)
        }
    }
}
