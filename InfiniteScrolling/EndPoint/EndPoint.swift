//
//  EndPoint.swift
//  InfiniteScrolling
//
//  Created by Alok Sinha on 2022-05-16.
//

import Foundation

enum Endpoint {
    
    case list(_ page: Int)
    case image(_ id: String)
    
    var url: URL? {
        var components = URLComponents()
        let base: String = "picsum.photos"
        components.scheme = "https"
        components.host = base
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    var path: String {
        switch self {
        case .list:
            return "/v2/list"
        case .image(let id):
            return "/id/\(id)/200/300"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        
        var queryItems = [URLQueryItem]()
        
        switch self {
        case .list(let page):
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        default:
            break
        }
        
        return queryItems
    }
}
