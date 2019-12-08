//
//  PeopleDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PeopleDetailedViewController: UIViewController {
    
    var userinfo: UserInfo!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        guard let user = userinfo else {
            return
        }
        nameLabel.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        emailLabel.text = "Email: \(user.email)"
        phoneLabel.text = "Phone: \(user.phone)"
        
        UserImage.getImage(for: user.picture.large) { [unowned self] (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success( let image):
                DispatchQueue.main.async {
                    self.personImage.image = image
                }
            }
        }
    }
}
