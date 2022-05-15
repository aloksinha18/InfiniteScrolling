//
//  RemoteFeedLoader.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-15.
//

import Foundation


class RemoteFeedLoader: ImageLoader {
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private let client: HTTPClient
    private let url : URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func loadImages(completion: @escaping (ImageLoader.Result) -> Void) {
        
        client.get(form: url) { result in
            switch result {
            case .success( let data):
                do {
                    let items = try self.feed(from: data)
                    completion(items)
                } catch {
                    completion(.failure(Error.invalidData))
                }
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    func feed(from data: Data) throws -> ImageLoader.Result {
        if let feed = try? JSONDecoder().decode(Root.self, from: data) {
            return .success(feed)
        }
        
        return .failure(Error.invalidData)
    }
}
