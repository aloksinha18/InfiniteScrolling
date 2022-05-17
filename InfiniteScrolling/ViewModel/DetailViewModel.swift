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
    private let feed: Feed
    
    init(feed: Feed, imageLoader: FeedImageDataLoader) {
        self.imageLoader = imageLoader
        self.feed = feed
    }
    
    func loadBlurImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = Endpoint.blurImage(feed.id).url else {
            completion(nil)
            return
        }
        
        imageLoader.loadImageData(from: url) { result in
            if let image = try? result.get() {
                completion(UIImage(data: image))
            }
        }
    }
    
    func loadGrayScaleImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = Endpoint.grayScale(feed.id).url else {
            completion(nil)
            return
        }
        imageLoader.loadImageData(from: url) { result in
            if let image = try? result.get() {
                completion(UIImage(data: image))
            }
        }
    }
    
    var authorName: String {
        return "Author: \(feed.author)"
    }
    
    var dimensions: String {
        return "Height: \(feed.height) Width: \(feed.width)"
    }
    
    var url: String {
        return "URL: \(feed.url)"
    }
    
    var downloadURL: String {
        return "Download URL: \(feed.downloadURL)"
    }
}
