//
//  FeedImageViewModel.swift
//  PicsumPhotos
//
//  Created by Alok Sinha on 2022-05-16.
//

import Foundation

class FeedImageViewModel {
    
    private let feedLoader: FeedLoader
    private var isLoading = false
    private var currentPage = 0
    
    var onFeedLoad: (([Feed]) -> Void )?
    
    var title: String {
        return "Picsum photos"
    }
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func load() {
        
        guard let url = Endpoint.list(currentPage).url else {
            return
        }
        
        guard !isLoading else { return }
        
        isLoading = true
        currentPage += 1
        
        feedLoader.loadFeed(url: url) { [weak self] result in
            if let feeds = try? result.get() {
                self?.onFeedLoad?(feeds)
                self?.isLoading = false
            }
        }
    }
}
