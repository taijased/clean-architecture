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
    
    // MARK: - Initializer
        
    public init(webRepository: IAMWebRepository) {
        self.webRepository = webRepository
    }
    
    // MARK: - Functions
    
    public func getAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void){
        // TODO: - Something do ..
        
        webRepository.fetchAll(completion: completion)
    }
}
