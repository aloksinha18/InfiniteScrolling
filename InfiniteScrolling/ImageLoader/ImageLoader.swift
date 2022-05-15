//
//  ImageLoader.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-15.
//

import Foundation

struct FeedImage {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}


protocol ImageLoader {
    typealias Result = Swift.Result<[FeedImage] , Error>
    func loadImages(completion: ([Result]) -> Void)
}
