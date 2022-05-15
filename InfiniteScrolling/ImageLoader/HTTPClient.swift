//
//  HTTPClient.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-15.
//

import Foundation

protocol HTTPClient {
    typealias HTTPClientResult = Swift.Result<Data, Error>
    func get(form url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
