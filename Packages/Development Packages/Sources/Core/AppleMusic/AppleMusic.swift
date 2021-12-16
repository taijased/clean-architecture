//
//  AppleMusic.swift
//  
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import Foundation

public struct AppleMusic {
    // MARK: - Properties
    
    public var id: String
    public var name: String
    public var artworkUrl100: String
    public var url: String
    
    // MARK: - Initializer
    
    public init(
        id: String,
        name: String,
        artworkUrl100: String,
        url: String
    ) {
        self.id = id
        self.name = name
        self.artworkUrl100 = artworkUrl100
        self.url = url
    }
}
