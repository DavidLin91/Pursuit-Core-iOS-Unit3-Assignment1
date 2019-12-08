//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var user = [UserInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData() {
        user = User.getUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let peopleDVC = segue.destination as? PeopleDetailedViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("")
        }
        peopleDVC.userinfo = user[indexPath.row]
    }

    func sortedSearch(for searchText: String) {
        user = User.getUser().filter { $0.name.first.lowercased().contains(searchText.lowercased())}
    }
    
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let userInfo = user[indexPath.row]
        cell.textLabel?.text = "\(userInfo.name.first.capitalized) \(userInfo.name.last.capitalized)"
        cell.detailTextLabel?.text = "\(userInfo.location.street), \(userInfo.location.city)"
        return cell
    }
}

extension PeopleViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        sortedSearch(for: searchText)
    }
}
