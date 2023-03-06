//
//  ImageLoader.swift
//  ios-wanted-photoViewer
//
//  Created by 이태영 on 2023/03/02.
//

import UIKit

enum NetworkError: Error {
    case transportError
    case serverError
    case missingData
}

final class ImageLoader {
    func loadImage(
        with request: Requestable,
        completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void
    ) {
        
        guard let url = request.convertURL() else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.transportError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode)
            else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                completionHandler(.failure(.missingData))
                return
            }
            
            completionHandler(.success(image))
        }.resume()
    }
}
