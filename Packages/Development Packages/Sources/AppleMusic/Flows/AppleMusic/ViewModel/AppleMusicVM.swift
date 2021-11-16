//
//  AppleMusicVM.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import Foundation
import Swinject
import Core
import Application

public protocol AppleMusicVMType {
    // MARK: - Properties
    
    var collectionViewModel: AMCollectionViewVMType { get }
}


public final class AppleMusicVM: AppleMusicVMType {
    // MARK: - Properties
    
    public let collectionViewModel: AMCollectionViewVMType
    
    public init(container: Container) {
        
        collectionViewModel = AMCollectionViewVM(cells: [])
        
        let facade = container.resolve(AppleMusicFacade.self)
        
        let fetchResult: (Result<[AppleMusic], Error>) -> Void = { [weak self] result in
            switch result {
            case .success(let musics):
                print(musics.count)
                self?.collectionViewModel.set(with: musics)
                break
                
            case .failure(_):
                // TODO: - Something
                break
            }
        }
        
        facade?.getAll(completion: fetchResult)
    }
}
