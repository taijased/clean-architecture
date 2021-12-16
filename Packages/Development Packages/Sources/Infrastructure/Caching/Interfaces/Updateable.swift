//
//  Updateable.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation

public protocol Updateable: AnyObject {
    // MARK: - Functions
    
    func insert<Entity: Cacheable>(
        _ item: Entity,
        _ completion: @escaping (Result<Any, Error>) -> Void
    )
    
    func insert<Entity: Cacheable>(
        _ items: [Entity],
        _ completion: @escaping (Result<Any, Error>) -> Void
    )
    
    func update<Entity: Cacheable>(
        _ item: Entity,
        predicate: NSPredicate,
        _ completion: @escaping (Result<Any, Error>) -> Void
    )
}


