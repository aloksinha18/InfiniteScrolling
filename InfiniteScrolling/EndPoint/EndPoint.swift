//
//  EndPoint.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-16.
//

import Foundation

enum Endpoint {
    
    case list
    case image(_ id: String)
    
    var url: URL? {
        var components = URLComponents()
        let base: String = "picsum.photos"
        components.scheme = "https"
        components.host = base
        components.path = path
        return components.url
    }
    
    var path: String {
        switch self {
        case .list:
            return "/v2/list"
        case .image(let id):
            return "\(id)/200/300"
        }
    }
}
