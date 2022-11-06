//
//  Supreme.swift
//  Enhance
//
//  Created by Michael Gillund on 8/19/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

class Supreme: UITableViewController {
    
    var usCell: UITableViewCell = UITableViewCell()
    var euCell: UITableViewCell = UITableViewCell()
    
    var index = 0
    var section = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        view.tintColor = .label
        self.navigationItem.title = "Supreme"
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = false
        self.tableView.separatorStyle = .singleLine
        self.tableView.backgroundColor = .systemGroupedBackground
        
        cells()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func cells(){
        self.usCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        self.usCell.textLabel?.text = "Auto-Checkout"
        self.usCell.detailTextLabel?.text = "US"
        self.usCell.backgroundColor = .clear
        self.usCell.accessoryType = .disclosureIndicator
        self.usCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.usCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.usCell.imageView?.image = UIImage(named: "SupremeBox.png")
        
        self.euCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        self.euCell.textLabel?.text = "Auto-Checkout"
        self.euCell.detailTextLabel?.text = "EU"
        self.euCell.backgroundColor = .clear
        self.euCell.accessoryType = .disclosureIndicator
        self.euCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.euCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.euCell.imageView?.image = UIImage(named: "SupremeBox.png")
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0: return 2
            default: fatalError("Unknown number of sections")
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
            case 0:
                switch(indexPath.row) {
                case 0: return self.usCell
                case 1: return self.euCell
                default: fatalError("Unknown row in section 0")
                }
            default: fatalError("Unknown section")
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        section = indexPath.section
        
        if section == 0 && index == 0 {
            let us:UIViewController = UIStoryboard(name: "Supreme", bundle: nil).instantiateViewController(withIdentifier: "US") as UIViewController
            self.navigationController?.pushViewController(us, animated: true)
        }
        if section == 0 && index == 1 {
            let eu:UIViewController = UIStoryboard(name: "Supreme", bundle: nil).instantiateViewController(withIdentifier: "EU") as UIViewController
            self.navigationController?.pushViewController(eu, animated: true)
        }
    }
}

