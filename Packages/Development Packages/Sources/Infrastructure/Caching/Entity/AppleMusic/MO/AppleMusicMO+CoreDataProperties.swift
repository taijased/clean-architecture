//
//  AppleMusicMO+CoreDataProperties.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public extension AppleMusicMO {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<AppleMusicMO> {
        NSFetchRequest<AppleMusicMO>(entityName: "AppleMusic")
    }

    @NSManaged
    var id: String
    
    @NSManaged
    var name: String
    
    @NSManaged
    var artworkUrl100: String
    
    @NSManaged
    var url: String
}

