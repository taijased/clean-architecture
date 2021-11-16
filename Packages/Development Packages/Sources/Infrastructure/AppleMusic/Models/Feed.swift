//
//  Feed.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation

struct Feed: Codable {
    // MARK: - Properties
    
    var title: String
    var results: [AppleSong]
}
