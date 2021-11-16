//
//  DeepLink.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation

public enum DeepLink: Equatable {
    //MARK: - Cases
    
    case appleMusic(String)
    
    //MARK: - Initializer
    
    public init?(url: URL) {
        let id = url.lastPathComponent
        if id != "/" {
            self = .appleMusic(id)
        } else {
            return nil
        }
    }
}
