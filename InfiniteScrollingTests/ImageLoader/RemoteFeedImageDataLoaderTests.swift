//
//  RemoteFeedImageDataLoaderTests.swift
//  InfiniteScrollingTests
//
//  Created by Alok Sinha on 2022-05-15.
//

import XCTest
@testable import InfiniteScrolling

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
                    completion(.success(data))
                } else {
                    completion(.failure(Error.invalidData))
                }
            case .failure:
                completion(.failure(Error.invalidData))
            }
        }
    }
}


final class RemoteFeedImageDataLoaderTests: XCTestCase {
    
    func testEmptyData() {
        let client = MockHTTPClient()
        let sut = RemoteFeedImageDataLoader(client: client)
        let exp = expectation(description: "Wait for load completion")
        
        let emptyData = Data()
        
        sut.loadImageData(from: anyURL()) { result in
            switch result {
            case let (.failure(receivedError as NSError)):
                XCTAssertEqual(receivedError, RemoteFeedImageDataLoader.Error.invalidData as NSError)
            default:
                XCTFail("Expecting failure")
            }
        }
        
        client.completeWithSuccess(with: emptyData)
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }
    
    func testNonEmptyData() {
        let client = MockHTTPClient()
        let sut = RemoteFeedImageDataLoader(client: client)
        let exp = expectation(description: "Wait for load completion")
        
        let nonEmptyData = "npn-empty data".data(using: .utf8)!
        
        sut.loadImageData(from: anyURL()) { result in
            switch result {
            case let (.success(data)):
                XCTAssertEqual(data, nonEmptyData)
            default:
                XCTFail("Expecting success")
            }
        }
        
        client.completeWithSuccess(with: nonEmptyData)
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
    }
    
    func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
}
