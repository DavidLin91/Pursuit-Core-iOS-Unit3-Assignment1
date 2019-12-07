//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    let results: [Users]
}

struct Users: Codable {
    let name: Name
    let email: String
    let phone: String
}

struct Name: Codable {
    let first: String
    let last: String
}

extension UserInfo {
    static func getUserInfo() -> [Users] {
        var userArr = [Users]()
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError()
        }
        do {
            let data = try Data.init(contentsOf: fileURL)
            let userData = try JSONDecoder().decode(UserInfo.self, from: data)
            userArr = userData.results
        } catch {
            fatalError("\(error)")
        }
        return userArr
    }
}
