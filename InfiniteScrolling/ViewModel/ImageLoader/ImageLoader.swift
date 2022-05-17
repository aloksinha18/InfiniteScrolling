//
//  ImageLoader.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-15.
//

import Foundation

struct FeedImage: Equatable, Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias Root = [FeedImage]

protocol ImageLoader {
    typealias Result = Swift.Result<[FeedImage] , Error>
    func loadImages(url: URL, completion: @escaping (ImageLoader.Result) -> Void)
}


protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void)
}
