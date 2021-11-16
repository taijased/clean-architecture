//
//  AppleMusicCoordinator.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit
import Swinject
import Infrastructure

public final class AppleMusicCoordinator: BaseCoordinator {
    // MARK: - Properties
    
    private let container: Container
    
    private weak var viewController: UIViewController?
    
    private weak var parent: UIViewController?
    
    // MARK: - Initializer
    
    public init(
        container: Container,
        parent: UIViewController
    ) {
        self.parent = parent
        self.container = container
    }
    
    // MARK: - Override functions
    
    public override func start() {
        super.start()
        guard let parent = parent else { return }
        
        let viewModel = AppleMusicVM(container: container)
        let viewController = AppleMusicViewController(viewModel: viewModel)
        self.viewController = viewController
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        
        parent.present(viewController, animated: true, completion: nil)
    }
    
    public override func complete() {
        super.complete()
        guard let vc = self.parent?.children
            .compactMap({ $0 as? AppleMusicViewController })
            .first else { return }
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}
