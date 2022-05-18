//
//  RemoteFeedImageDataLoader.swift
//  PicsumPhotos
//
//  Created by Alok Sinha on 2022-05-15.
//

import Foundation

final class RemoteFeedImageDataLoader: FeedImageDataLoader {
    
    typealias Result = FeedImageDataLoader.Result
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void)   {
        
        client.get(form: url) { result in
            switch result {
                
            case .success( let data ):
                if  !data.isEmpty {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                } else {
                    completion(.failure(Error.invalidData))
                }
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

