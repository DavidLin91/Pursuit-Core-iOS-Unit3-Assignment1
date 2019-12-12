//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

// stock price ,
// VC -  tableView: contains date, opening price
// DVC - UIImage, label to represent data, label to represent opening/ closing price


import Foundation

struct AppleStockData: Codable {
    let date: String
    let open: Double
    let close: Double
    let label: String
}

var appleStocks = [AppleStockData] ()

extension AppleStockData {
    static func getStock() -> [AppleStockData] {
        var stockInfo = [AppleStockData]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else {
            fatalError("")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let stockData = try JSONDecoder().decode([AppleStockData].self, from: data)
            stockInfo = stockData.sorted {$0.date < $1.date}
        } catch {
            fatalError("\(error)")
        }
        return stockInfo
    }
}
