//
//  ImageCollectionViewCell.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-16.
//

import Foundation
import UIKit


class ImageCollectionViewCell: UICollectionViewCell {
    
    var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .green
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
