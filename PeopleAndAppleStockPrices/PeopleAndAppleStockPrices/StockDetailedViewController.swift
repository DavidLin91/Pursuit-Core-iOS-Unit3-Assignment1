//
//  StockDetailedViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by David Lin on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailedViewController: UIViewController {
    
    var appleStockDetails: AppleStockData!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var upDownImage: UIImageView!
    @IBOutlet weak var openingPrice: UILabel!
    @IBOutlet weak var closingPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    
    func loadData() {
        labelDescription.text = appleStockDetails.label
        openingPrice.text = "Open Price: $\(appleStockDetails.open.description)"
        closingPrice.text = "Close Price: $\(appleStockDetails.close.description)"
//        if appleStockDetails.open > appleStockDetails.close {
//            upDownImage.image = UIImage(named: "thumbsup")
//            print(\(appleStockDetails.open))
//        }
    }
    
}
