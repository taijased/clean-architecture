//
//  Deleteable.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public protocol Deleteable: AnyObject {
    // MARK: - Functions
    
    func deleteAll(
        by request: NSFetchRequest<NSFetchRequestResult>,
        _ completion: @escaping (Result<Any, Error>) -> Void
    )
    
    func deleteAll(
        for requests: [NSFetchRequest<NSFetchRequestResult>],
        _ completion: @escaping (Result<Any, Error>) -> Void
    )
    
    func deleteBy(_ objectId: NSManagedObjectID)
    
    func deleteBy(
        by request: NSFetchRequest<NSFetchRequestResult>,
        _ completion: @escaping (Result<Any, Error>) -> Void
    )
}
