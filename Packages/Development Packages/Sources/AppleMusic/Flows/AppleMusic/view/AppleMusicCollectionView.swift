//
//  AppleMusicCollectionView.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit
import Core

protocol AppleMusicCollectionViewDelegate: AnyObject {
    func didSelectItemAt(appleSong: AppleMusic)
}



final class AppleMusicCollectionView: UICollectionView {
    
    var viewModel: AMCollectionViewVMType?
    weak var collectionDelegate: AppleMusicCollectionViewDelegate?

    init(viewModel: AMCollectionViewVMType) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupUI()
        binding()
    }
    
    private func binding() {
        viewModel?.onReloadData = { [weak self] in
            self?.reloadData()
        }
    }
    
    private func setupUI() {
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(AMCollectionViewCell.self, forCellWithReuseIdentifier: AMCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0, right:  16.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension AppleMusicCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: AMCollectionViewCell.reuseId, for: indexPath) as? AMCollectionViewCell
        
        guard
            let collectionViewCell = cell,
            let viewModel = viewModel,
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        else {
            return UICollectionViewCell()
        }
        
        collectionViewCell.configure(with: cellViewModel)
        
        return collectionViewCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        guard let appleSong = viewModel.viewModelForSelectedRow() else { return }
        collectionDelegate?.didSelectItemAt(appleSong: appleSong)
    }
}



// MARK: - UICollectionViewDelegateFlowLayout
extension AppleMusicCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.sizeForItemAt() ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.minimumInteritemSpacingForSectionAt ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.minimumLineSpacingForSectionAt ?? 0
    }
}
