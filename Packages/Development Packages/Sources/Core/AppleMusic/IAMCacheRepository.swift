//
//  IAMCacheRepository.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation


public protocol IAMCacheRepository {
    // MARK: - Functions
    
    func getAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void)
    
    func add(
        items: [AppleMusic],
        completion: @escaping (Result<Any, Error>) -> Void
    )
}
