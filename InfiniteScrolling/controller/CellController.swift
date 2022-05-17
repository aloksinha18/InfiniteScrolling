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
    
    private let imageDataLoader: FeedImageDataLoader
    private let feedImage: FeedImage
    
    init(feedImage: FeedImage, imageDataLoader: FeedImageDataLoader) {
        self.feedImage = feedImage
        self.imageDataLoader = imageDataLoader
    }
    
    func view(for collectionView: UICollectionView, indexpath: IndexPath) -> ImageCollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexpath) as! ImageCollectionViewCell
        
        if let url = Endpoint.image(feedImage.id).url {
           loadImage(url: url, imageDataLoader: imageDataLoader, for: collectionViewCell)
        }
        
        return collectionViewCell
    }
    
    var feed: FeedImage {
        return self.feedImage
    }
    
    private func loadImage(url: URL, imageDataLoader: FeedImageDataLoader, for cell: ImageCollectionViewCell) {
        cell.activityView.startAnimating()
        imageDataLoader.loadImageData(from: Endpoint.image(feedImage.id).url!) { result in
            cell.activityView.stopAnimating()
            if let imageData = try? result.get() {
                cell.imageView.image = UIImage(data: imageData)
            }
        }
    }
}

