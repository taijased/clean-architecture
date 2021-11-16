//
//  AMWebRepositoryInterface.swift
//  
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import Foundation

public protocol AMWebRepositoryInterface {
    // MARK: - Functions
    
    func fetchAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void)
}
