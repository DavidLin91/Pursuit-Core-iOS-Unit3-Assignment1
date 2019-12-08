//
//  People.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct User: Codable {
    let results: [UserInfo]
}

struct UserInfo: Codable {
    let name: Name
    let email: String
    let phone: String
    let location: Location
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let street: String
    let city: String
}

struct Picture: Codable {
    let large: String
}


extension User {
    static func getUser() -> [UserInfo] {
        var userArr = [UserInfo]()
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError()
        }
        do {
            let data = try Data.init(contentsOf: fileURL)
            let userData = try JSONDecoder().decode(User.self, from: data)
            userArr = userData.results.sorted {$0.name.first < $1.name.first}
        } catch {
            fatalError("\(error)")
        }
        return userArr
    }
}
