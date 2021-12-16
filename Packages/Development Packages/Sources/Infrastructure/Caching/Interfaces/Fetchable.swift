//
//  Fetchable.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public protocol Fetchable: AnyObject {
    // MARK: - Functions
    
    func fetch<Entity: Cacheable>(
        sort: [NSSortDescriptor]?,
        predicate: NSPredicate?,
        fetchLimit: Int?,
        _ completion: @escaping (Result<[Entity], Error>) -> Void
    )
    
    func fetch<Entity: Cacheable>(
        sort: [NSSortDescriptor]?,
        predicate: NSPredicate?,
        relatedPaths: [String]?,
        fetchLimit: Int?,
        _ completion: @escaping (Result<[Entity], Error>) -> Void
    )
    
    func isEntityExists(
        for request: NSFetchRequest<NSFetchRequestResult>,
        _ completion: @escaping (Result<Bool, Error>) -> Void
    )
}

