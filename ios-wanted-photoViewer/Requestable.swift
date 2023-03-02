//
//  Requestable.swift
//  ios-wanted-photoViewer
//
//  Created by 이태영 on 2023/03/02.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var method: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}

extension Requestable {
    func convertURL() -> URL? {
        guard var component = URLComponents(string: baseURL) else {
            return nil
        }
        
        component.path = path
        component.queryItems = query
        
        return component.url
    }
}

final class ImageLoadRequest: Requestable {
    var baseURL: String = "https://wallpaperaccess.com"
    var method: String = "GET"
    var path: String
    var query: [URLQueryItem] = []
    
    init(path: String) {
        self.path = "/download/europe-4k-" + path
    }
}
