//
//  UserImage.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/8/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

enum Issue: Error {
    case urlIssue(String)
    case dataTaskError(Error)
}

struct UserImage {
    static func getImage(for urlString: String, completion: @escaping (Result<UIImage?, Issue>) -> ()) {
    guard let url = URL(string: urlString) else {
    completion(.failure(.urlIssue(urlString)))
    return
    }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.dataTaskError(error)))
                return
            }
            if let data = data {
                let image = UIImage(data: data)
                completion(.success(image))
            }
        }
        dataTask.resume()
    }
}
