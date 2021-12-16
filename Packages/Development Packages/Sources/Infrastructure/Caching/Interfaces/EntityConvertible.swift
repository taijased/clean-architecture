//
//  EntityConvertible.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public protocol EntityConvertible where Self: NSManagedObject {
    // MARK: - Constants
    
    associatedtype Cacheable
    
    // MARK: - Properties
    
    static var entityName: String { get }
    
    // MARK: - Functions
    
    func toEntity() -> Cacheable?
}

public extension EntityConvertible {
    // MARK: - Properties
    
    static var entityName: String {
        String(describing: self).replacingOccurrences(of: "MO", with: "")
    }
}
