//
//  FeedImageViewModel.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-16.
//

import Foundation

class FeedImageViewModel {
    
    private let feedLoader: ImageLoader
    private let imageLoader: FeedImageDataLoader
    
    var onFeedLoad: (([FeedImage]) -> Void )?
    
    init(feedLoader: ImageLoader,
         imageLoader: FeedImageDataLoader) {
        self.feedLoader = feedLoader
        self.imageLoader = imageLoader
    }
    
    func load() {
        feedLoader.loadImages { [weak self] result in
            if let feeds = try? result.get() {
                self?.onFeedLoad?(feeds)
            }
        }
    }
}
