//
//  AMCollectionViewVM.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit
import Core

public protocol AMCollectionViewVMType {
    // MARK: - Properties
    
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    
    // MARK: - Callbacks
    
    var onReloadData: (() -> Void)? { get set }
    
    // MARK: - Functions
    
    func set(with cells: [AppleMusic])
    
    func sizeForItemAt() -> CGSize
    
    func numberOfRows() -> Int
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> AMCollectionViewCellVM?
    
    func viewModelForSelectedRow() -> AppleMusic?
    
    func selectItem(atIndexPath indexPath: IndexPath)
}

public final class AMCollectionViewVM: AMCollectionViewVMType {
    // MARK: - Properties
    
    public var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    
    public var minimumLineSpacingForSectionAt: CGFloat = 40.0
    
    private var selectedIndexPath: IndexPath?
    
    private var cells: [AppleMusic]?
    
    // MARK: - Callbacks
    
    public var onReloadData: (() -> Void)?
    
    // MARK: - Initializer
    
    public init(cells: [AppleMusic]) {
        self.cells = cells
        onReloadData?()
    }
    
    // MARK: - Functions
    
    public func set(with cells: [AppleMusic]) {
        self.cells = cells
        onReloadData?()
    }
    
    public func sizeForItemAt() -> CGSize {
        let width = (UIScreen.main.bounds.width - 60) * 0.5
        let height = (width * 2) / 3
        
        return CGSize(width: width, height: height)
    }
    
    public func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    public func cellViewModel(forIndexPath indexPath: IndexPath) -> AMCollectionViewCellVM? {
        guard let cells = cells else {
            return nil
        }
        let cell = cells[indexPath.row]
        return AMCollectionViewCellVM(cell: cell)
    }
    
    public func viewModelForSelectedRow() -> AppleMusic? {
        guard
            let selectedIndexPath = selectedIndexPath,
            let cells = cells
        else {
            return nil
        }
        return cells[selectedIndexPath.row]
    }
    
    public func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
