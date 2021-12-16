//
//  AppleMusicFacade.swift
//  
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import Foundation
import Core

public final class AppleMusicFacade {
    // MARK: - Properties
    
    private let webRepository: IAMWebRepository
    
    private let cache: IAMCacheRepository
    
    // MARK: - Initializer
        
    public init(
        webRepository: IAMWebRepository,
        cache: IAMCacheRepository
    ) {
        self.webRepository = webRepository
        self.cache = cache
    }
    
    // MARK: - Functions
    
    public func getAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void) {
        // TODO: - Something do ..
        
        cache.getAll { [weak self] result in
            switch result {
            case .success(let items):
                if items.isEmpty {
                    self?.fetchAll(completion: completion)
                } else {
                    completion(.success(items))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func fetchAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void) {
        webRepository.fetchAll { result in
            switch result {
            case .success(let items):
                self.cache.add(items: items, completion: { res in
                    print(res)
                })
                completion(.success(items))
            case .failure(let error):
                print(error)
            }
        }
    }
}

