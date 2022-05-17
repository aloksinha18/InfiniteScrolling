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
    private var isLoading = false
    private var currentPage = 0
    
    var onFeedLoad: (([FeedImage]) -> Void )?
    
    init(feedLoader: ImageLoader,
         imageLoader: FeedImageDataLoader) {
        self.feedLoader = feedLoader
        self.imageLoader = imageLoader
    }
    
    func load() {
        if isLoading { return }
        
        isLoading = true
        currentPage += 1
        print(Endpoint.list(currentPage).url!)
        feedLoader.loadImages(url: Endpoint.list(currentPage).url!) { [weak self] result in
            if let feeds = try? result.get() {
                self?.onFeedLoad?(feeds)
                self?.isLoading = false
            }
        }
    }
}
