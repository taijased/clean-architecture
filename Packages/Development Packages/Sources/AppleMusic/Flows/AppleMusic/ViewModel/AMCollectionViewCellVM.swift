//
//  AMCollectionViewCellVM.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation
import Core

public struct AMCollectionViewCellVM {
    // MARK: - Properties
    
    public let label: String
    
    public let imageURL: String
    
    // MARK: - Initializer
    
    public init(cell: AppleMusic) {
        self.imageURL = cell.artworkUrl100
        self.label = cell.name
    }
}
