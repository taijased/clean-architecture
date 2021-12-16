//
//  AppleMusicMO+CoreDataClass.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation
import CoreData
import Core

@objc(AppleMusicMO)
public final class AppleMusicMO: NSManagedObject, EntityConvertible {
    // MARK: - Functions
    
    public func toEntity() -> AppleMusic? {
        AppleMusic(
            id: id,
            name: name,
            artworkUrl100: artworkUrl100,
            url: url
        )
    }
}

