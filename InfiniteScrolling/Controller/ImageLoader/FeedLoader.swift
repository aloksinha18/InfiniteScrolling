//
//  ImageLoader.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-15.
//

import Foundation

typealias Root = [Feed]

protocol FeedLoader {
    typealias Result = Swift.Result<[Feed] , Error>
    func loadImages(url: URL, completion: @escaping (FeedLoader.Result) -> Void)
}


protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void)
}
