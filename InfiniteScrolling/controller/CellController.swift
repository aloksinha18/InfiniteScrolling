//
//  CellController.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-16.
//

import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class CellController {
    
    private let imageLoader: FeedImageDataLoader
    private let feedImage: FeedImage
    
    init(feedImage: FeedImage, imageLoader: FeedImageDataLoader) {
        self.feedImage = feedImage
        self.imageLoader = imageLoader
    }
    
    func view(for collectionView: UICollectionView, indexpath: IndexPath) -> ImageCollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexpath) as! ImageCollectionViewCell
        imageLoader.loadImageData(from: Endpoint.image(feedImage.id).url!) { result in
            if let imageData = try? result.get() {
                collectionViewCell.iconImageView.image = UIImage(data: imageData)
            }
        }
        return collectionViewCell
    }
}

