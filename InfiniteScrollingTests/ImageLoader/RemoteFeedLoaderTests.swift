//
//  RemoteFeedLoaderTests.swift
//  InfiniteScrollingTests
//
//  Created by Alok Sinha on 2022-05-15.
//

import XCTest
import Foundation
@testable import InfiniteScrolling

protocol HTTPClient {
    typealias HTTPClientResult = Swift.Result<Data, Error>
    func get(form url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

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

class MockHTTPClient: HTTPClient {
    var completion: ((HTTPClientResult) -> Void)?
    
    func get(form url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        self.completion = completion
    }
    
    func completeWithSuccess(with data: Data) {
        completion?(.success(data))
    }
}

final class RemoteFeedLoaderTests: XCTestCase {
    
    
    func testSuccesfulAPIResponse() {
        let client  = MockHTTPClient()
        let sut = RemoteFeedLoader(url: anyURL(), client: client)
        
        let dataString = """
                            [{"id":"0","author":"Alejandro Escamilla","width":5616,"height":3744,"url":"https://unsplash.com/photos/yC-Yzbqy7PY","download_url":"https://picsum.photos/id/0/5616/3744"}]
                         """
        let expectedFeed = [FeedImage(id: "0", author: "Alejandro Escamilla", width: 5616, height: 3744, url: "https://unsplash.com/photos/yC-Yzbqy7PY", downloadURL: "https://picsum.photos/id/0/5616/3744")]
        
        let expectation = expectation(description: "wait for images to load")
        
        sut.loadImages { result in
            switch result {
            case .success(let feed):
                
                XCTAssertEqual(feed, expectedFeed)
            default:
                XCTFail("This should not fail and passed instead as this is success case check input and exppected output")
            }
            expectation.fulfill()
        }
        
        client.completeWithSuccess(with: dataString.data(using: .utf8)!)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
}
