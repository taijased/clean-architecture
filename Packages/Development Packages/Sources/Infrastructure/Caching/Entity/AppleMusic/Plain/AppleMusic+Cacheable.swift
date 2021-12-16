//
//  AppleMusic+Cacheable.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Core
import CoreData

extension AppleMusic: Cacheable {
    // MARK: - Functions
    
    public func toManagedObject(in context: NSManagedObjectContext) -> AppleMusicMO {
        let mo: AppleMusicMO = NSEntityDescription.insertNewObject(
            forEntityName: "AppleMusicMO",
            into: context
        ) as! AppleMusicMO
        
        mo.id = id
        mo.name = name
        mo.artworkUrl100 = artworkUrl100
        mo.url = url
        
        return mo
    }
    
    public func updateManagedObject(_ managedObject: AppleMusicMO) {
        managedObject.id = id
        managedObject.name = name
        managedObject.artworkUrl100 = artworkUrl100
        managedObject.url = url
    }
}

