//
//  AppleMusicViewController.swift
//  clean-architecture
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import UIKit
import Swinject
import Infrastructure
import Application
import Core

final class AppleMusicViewController: UIViewController {
    
    private let viewModel: AppleMusicVMType
    
    private let collectionView: AppleMusicCollectionView
    
    init(viewModel: AppleMusicVMType) {
        self.viewModel = viewModel
        self.collectionView = AppleMusicCollectionView(viewModel: viewModel.collectionViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupIU()
    }
 
    private func setupIU() {
        view.addSubview(collectionView)
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.collectionDelegate = self
    }
}


extension AppleMusicViewController: AppleMusicCollectionViewDelegate {
    func didSelectItemAt(appleSong: AppleMusic) {
        let detailsViewController = DetailsViewController()
        detailsViewController.appleSong = appleSong
        self.present(detailsViewController, animated: true, completion: nil)
    }
}
