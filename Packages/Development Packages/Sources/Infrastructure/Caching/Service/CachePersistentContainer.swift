//
//  CachePersistentContainer.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public final class CachePersistentContainer: NSPersistentContainer {
    // MARK: - Constants
    
    private enum Constants {
        static let defaultFolderName: String = "com.yappy.cache"
    }
    
    // MARK: - Functions
    
    override public class func defaultDirectoryURL() -> URL {
        super.defaultDirectoryURL().appendingPathComponent(Constants.defaultFolderName)
    }
}
