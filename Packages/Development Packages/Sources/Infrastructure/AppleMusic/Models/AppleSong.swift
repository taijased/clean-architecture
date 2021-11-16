//
//  AppleSong.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation

public struct AppleSong: Codable {
    // MARK: - Properties
    
    public var id: String
    public var name: String
    public var artworkUrl100: String
    public var url: String
}
