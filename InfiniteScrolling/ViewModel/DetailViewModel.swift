//
//  DetailViewModel.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-17.
//

import Foundation
import UIKit

class DetailViewModel {
    private let imageLoader: FeedImageDataLoader
    private let feed: FeedImage

    init(feed: FeedImage, imageLoader: FeedImageDataLoader) {
        self.imageLoader = imageLoader
        self.feed = feed
    }
    
    func loadBlurImage(completion: @escaping (UIImage) -> Void) {
        print(Endpoint.blurImage(feed.id).url!)
        imageLoader.loadImageData(from: Endpoint.blurImage(feed.id).url!) { result in
            if let image = try? result.get() {
               completion(UIImage(data: image)!)
            }
        }
    }
    
    func loadGrayScaleImage(completion: @escaping (UIImage) -> Void) {
        print(Endpoint.grayScale(feed.id).url!)
        imageLoader.loadImageData(from: Endpoint.grayScale(feed.id).url!) { result in
            if let image = try? result.get() {
               completion(UIImage(data: image)!)
            }
        }
    }
    
    var authorName: String {
        return feed.author
    }
}
