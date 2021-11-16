//
//  BaseCoordinator.swift
//  
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import Foundation

open class BaseCoordinator {
    //MARK: - Properties
    
    private weak var parent: BaseCoordinator?
    
    private var children: [BaseCoordinator] = []
    
    // MARK: - Initializer
    
    public init() {}
    
    //MARK: - Functions
    
    public func coordinate(to coordinator: BaseCoordinator) {
        coordinator.parent = self
        children.append(coordinator)
        coordinator.start()
    }
    
    open func start() {
        print("\(name) did start")
    }
    
    open func complete() {
        parent?.remove(coordinator: self)
        print("\(name) did complete")
    }
    
    public var onComplete: Void = () {
        didSet { complete() }
    }
    
    // MARK: - Private
    
    private func remove(coordinator: BaseCoordinator) {
        if let index = children.firstIndex(where: { $0 === coordinator}) {
            children.remove(at: index)
        }
        coordinator.parent = nil
    }
    
    private var name: String {
        String(describing: type(of: self))
    }
}
