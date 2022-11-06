//
//  Settings.swift
//  Enhance
//
//  Created by Michael Gillund on 5/14/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import SafariServices

var theme: Bool!

class Settings: UITableViewController, SFSafariViewControllerDelegate {
    
    var userCell: UITableViewCell = UserCell()
    var profileCell: UITableViewCell = ProfileCell()
    var discordCell: UITableViewCell = UITableViewCell()
    var proxiesCell: UITableViewCell = ProxiesCell()
    var googleCell: UITableViewCell = GoogleCell()
    var appearanceCell: UITableViewCell = UITableViewCell()
    var twitterCell: UITableViewCell = TwitterCell()
    var joinDiscordCell: UITableViewCell = DiscordCell()
    var splashCell: UITableViewCell = SplashCell()
    
    var index = 0
    var section = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        view.tintColor = .label
        self.navigationItem.title = "Settings"
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        logoutButton.setTitleColor(UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00), for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        self.tableView.tableFooterView = UIView()
//        self.tableView.isScrollEnabled = false
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        cells()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func cells(){
        self.userCell.backgroundColor = .clear
        self.userCell.selectionStyle = .none
        
        self.splashCell.backgroundColor = .clear
        self.splashCell.selectionStyle = .none
        
        self.profileCell.backgroundColor = .clear
        self.profileCell.selectionStyle = .none
        
        
        
        self.discordCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        self.discordCell.textLabel?.text = "Discord"
        self.discordCell.detailTextLabel?.text = "Restock Monitors"
        self.discordCell.backgroundColor = .clear
//        self.discordCell.accessoryType = .disclosureIndicator
        self.discordCell.selectionStyle = .none
        self.discordCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.discordCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.discordCell.imageView?.image = UIImage(named: "DiscordBox.png")
        
//        self.proxiesCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
//        self.proxiesCell.textLabel?.text = "Proxies"
//        self.proxiesCell.detailTextLabel?.text = "Enter Proxies"
        self.proxiesCell.backgroundColor = .clear
////        self.proxiesCell.accessoryType = .disclosureIndicator
        self.proxiesCell.selectionStyle = .none
//        self.proxiesCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        self.proxiesCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        self.proxiesCell.imageView?.image = UIImage(named: "Proxy.png")
        
//        self.googleCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
//        self.googleCell.textLabel?.text = "Google Login"
//        self.googleCell.detailTextLabel?.text = "Faster Captcha Solving"
        self.googleCell.backgroundColor = .clear
//        self.googleCell.accessoryType = .disclosureIndicator
        self.googleCell.selectionStyle = .none
//        self.googleCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        self.googleCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        self.googleCell.imageView?.image = UIImage(named: "Google.png")
        
        self.appearanceCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        self.appearanceCell.textLabel?.text = "Appearance"
        self.appearanceCell.detailTextLabel?.text = "Light & Dark Theme"
        self.appearanceCell.backgroundColor = .clear
//        self.appearanceCell.accessoryType = .disclosureIndicator
        self.appearanceCell.selectionStyle = .none
        self.appearanceCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.appearanceCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.appearanceCell.imageView?.image = UIImage(named: "Theme.png")
        
//        self.twitterCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
//        self.twitterCell.textLabel?.text = "Twitter"
//        self.twitterCell.detailTextLabel?.text = "Enhance Twitter"
        self.twitterCell.backgroundColor = .clear
//        self.twitterCell.accessoryType = .disclosureIndicator
        self.twitterCell.selectionStyle = .none
//        self.twitterCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        self.twitterCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        self.twitterCell.imageView?.image = UIImage(named: "TwitterBox.png")
        
//        self.joinDiscordCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
//        self.joinDiscordCell.textLabel?.text = "Discord"
//        self.joinDiscordCell.detailTextLabel?.text = "Join Discord"
        self.joinDiscordCell.backgroundColor = .clear
//        self.joinDiscordCell.accessoryType = .disclosureIndicator
        self.joinDiscordCell.selectionStyle = .none
//        self.joinDiscordCell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        self.joinDiscordCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        self.joinDiscordCell.imageView?.image = UIImage(named: "DiscordBox.png")
        
    }
    @objc func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "lastLogin")
        
        let login = Login()
        login.modalPresentationStyle = .fullScreen
        login.modalTransitionStyle = .crossDissolve
        present(login, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 80
            case 1:
                return 80
            case 2:
                return 80
            default:
                return UITableView.automaticDimension
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        label.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        label.sizeToFit()
        return label
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
            case 0: return 1
            case 1: return 4
            case 2: return 2
            default: fatalError("Unknown number of sections")
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
            
            case 0:
                switch(indexPath.row) {
                case 0: return self.userCell
                default: fatalError("Unknown row in section 0")
                }
            case 1:
                switch(indexPath.row) {
                case 0: return self.splashCell
                case 1: return self.profileCell
                case 2: return self.proxiesCell
                case 3: return self.googleCell
//                case 3: return self.appearanceCell
                default: fatalError("Unknown row in section 0")
                }
            case 2:
                switch(indexPath.row) {
                case 0: return self.twitterCell
                case 1: return self.joinDiscordCell
                default: fatalError("Unknown row in section 1")
                }
            default: fatalError("Unknown section")
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return ""
        case 1: return "   GENERAL"
        case 2: return "   EXTRA"
        default: fatalError("Unknown section")
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        section = indexPath.section
        
//        if section == 0 && index == 0 {
//            let profiles = Profiles()
//            self.navigationController?.pushViewController(profiles, animated: true)
//        }
        if section == 1 && index == 0 {
//            let splash = TabViewContainerViewController<Browser>.init(theme: TabViewThemeDark())
//            self.navigationController?.pushViewController(splash, animated: true)
            let splash = UINavigationController(rootViewController: Splash())
            present(splash, animated: true, completion: nil)
        }
        if section == 1 && index == 1 {
            let discord = UINavigationController(rootViewController: MultiProfiles())
            present(discord, animated: true, completion: nil)
        }
        if section == 1 && index == 2 {
            let proxy = UINavigationController(rootViewController: Proxies())
            present(proxy, animated: true, completion: nil)
        }
        if section == 1 && index == 3 {
            let google = UINavigationController(rootViewController: DiscordChannelListVC())
            present(google, animated: true, completion: nil)
        }
//        if section == 1 && index == 4 {
//            let theme = UINavigationController(rootViewController: ThemeTableViewController())
//            present(theme, animated: true, completion: nil)
//        }

        
        if section == 2 && index == 0 {
            let twUrl = URL(string: "twitter://user?screen_name=EnhanceAIO")!
            let twUrlWeb = URL(string: "https://www.twitter.com/EnhanceAIO")!
            if UIApplication.shared.canOpenURL(twUrl){
               UIApplication.shared.open(twUrl, options: [:],completionHandler: nil)
            }else{
               UIApplication.shared.open(twUrlWeb, options: [:], completionHandler: nil)
            }
        }
        if section == 2 && index == 1 {
            let urlString = "https://discord.gg/79Uwa2N"
            if let url = URL(string: urlString) {
                let safari = SFSafariViewController(url: url)
                safari.delegate = self
                safari.modalPresentationStyle = UIModalPresentationStyle.popover
                present(safari, animated: true, completion: nil)
            }
        }
    }
}
