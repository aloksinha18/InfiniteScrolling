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
    
    init(imageLoader: FeedImageDataLoader) {
        self.imageLoader = imageLoader
    }
    
    func view(for collectionView: UICollectionView, indexpath: IndexPath) -> ImageCollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexpath) as! ImageCollectionViewCell
        return collectionViewCell
    }
}

