//
//  AMCollectionViewCell.swift
//  
//
//  Created by Maxim Spiridonov on 15.11.2021.
//

import UIKit

final class AMCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "AMCollectionViewCell"

    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 10
        view.layer.position = view.center
        view.layer.shadowColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with viewModel: AMCollectionViewCellVM) {
        myImageView.set(imageURL: viewModel.imageURL)
        label.text = viewModel.label
    }
    
    private func setupUI() {
        contentView.addSubview(cardView)
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        cardView.addSubview(myImageView)
        myImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true


        cardView.addSubview(label)
        label.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
}
