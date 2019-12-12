//
//  StockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appleStockData = [AppleStockData]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var sections = [[AppleStockData]]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        
    }
    
    func loadData() {
        appleStockData = AppleStockData.getStock()
        
        let sortedData = appleStockData.sorted {$0.label < $1.label}
        let sectionNames: Set<String> = Set(sortedData.map {$0.date})
        sections = Array(repeating: appleStockData, count: sectionNames.count)
        
        var currentIndex = 0
        var currentSection = sortedData.first?.date ?? ""
        
        for stock in sortedData {
            if stock.date == currentSection {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentSection = stock.date
                sections[currentIndex].append(stock)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let appleStock = segue.destination as? StockDetailedViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("")
        }
        appleStock.appleStockDetails = AppleStockData[indexPath.section][indexPath.row]
    }
}


extension StockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "$\(stock.open.description)"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].first?.date
    }
}
