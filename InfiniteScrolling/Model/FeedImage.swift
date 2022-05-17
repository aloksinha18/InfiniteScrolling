//
//  FeedImage.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-18.
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
