//
//  InStock.swift
//  Enhance
//
//  Created by Michael Gillund on 9/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

class InStock: UIViewController {
    
    var stockLabel: Int = 0
    var itemName: String = ""
    var poop = ""
    
    let inStocklabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "IN STOCK"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let noStocklabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
//        label.text = "NOT IN STOCK + \(self.itemName)"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("poooooop",poop)
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        if stockLabel == 1{
            view.addSubview(inStocklabel)
            inStocklabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            inStocklabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }else{
            view.addSubview(noStocklabel)
            noStocklabel.text = "NOT IN STOCK + \(self.itemName)"
            noStocklabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            noStocklabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    
    }
}
