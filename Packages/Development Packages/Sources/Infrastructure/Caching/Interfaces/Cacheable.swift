//
//  Cacheable.swift
//  
//
//  Created by Maxim Spiridonov on 11.12.2021.
//

import Foundation
import CoreData

public protocol Cacheable {
    // MARK: - Constants
    
    associatedtype ManagedObject: EntityConvertible
    
    // MARK: - Functions
    
    @discardableResult
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject
    
    func updateManagedObject(_ managedObject: ManagedObject)
}

public extension Cacheable {
    func updateManagedObject(_ managedObject: ManagedObject) { }
}
