//
//  DetailViewModel.swift
//  PicsumPhotos
//
//  Created by Alok Sinha on 2022-05-17.
//

import Foundation
import UIKit

class DetailViewModel {
    
    private let imageLoader: FeedImageDataLoader
    private let feed: Feed
    
    private var blurImage: UIImage?
    private var grayscaleImage: UIImage?

    
    init(feed: Feed, imageLoader: FeedImageDataLoader) {
        self.imageLoader = imageLoader
        self.feed = feed
    }
    
    func loadBlurImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = Endpoint.blurImage(feed.id).url else {
            completion(nil)
            return
        }
        
        guard let image = blurImage else {
            imageLoader.loadImageData(from: url) { [weak self] result in
                if let data = try? result.get() {
                    let image = UIImage(data: data)
                    self?.blurImage = image
                    completion(image)
                }
            }
            return
        }
        
        completion(image)
    }
    
    func loadGrayScaleImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = Endpoint.grayScale(feed.id).url else {
            completion(nil)
            return
        }
        
        guard let image = grayscaleImage else {
            
            imageLoader.loadImageData(from: url) { [weak self] result in
                if let data = try? result.get() {
                    let image = UIImage(data: data)
                    self?.grayscaleImage = image
                    completion(image)
                }
            }
            return
        }
        
        completion(image)
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
