//
//  CacheServiceErrors.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation

public enum CacheServiceErrors: Error, LocalizedError {
    // MARK: - Cases
    
    case dataNotFound
    case undefinded
    case deformedData
    case savingDataError
    
    // MARK: - Properties
    
    public var errorDescription: String? {
        "CacheServiceErrors: An error has occurred, repeat the request"
    }
}
