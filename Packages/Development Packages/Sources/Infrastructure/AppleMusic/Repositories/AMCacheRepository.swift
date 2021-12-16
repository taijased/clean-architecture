//
//  AMCacheRepository.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation
import Core

public final class AMCacheRepository: IAMCacheRepository {
    // MARK: - Properties
    
    private let db: DatabaseStorable
    
    // MARK: - Initializer
    
    public init(db: DatabaseStorable) {
        self.db = db
    }
    
    public convenience init() {
        self.init(db: CacheService())
    }
    
    // MARK: - Functions
    
    public func getAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void) {
        let commitPredicate = NSPredicate(value: true)
        db.fetch(
            sort: nil,
            predicate: commitPredicate,
            fetchLimit: nil,
            completion
        )
    }
    
    public func add(
        items: [AppleMusic],
        completion: @escaping (Result<Any, Error>) -> Void
    ) {
        db.insert(items, completion)
    }
}
