//
//  Appearance.swift
//  Enhance
//
//  Created by Michael Gillund on 6/1/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

final class ThemeTableViewController: UITableViewController {
    
    var defaults = UserDefaults.standard
    
    var autoCell: UITableViewCell = UITableViewCell()
    var lightCell: UITableViewCell = UITableViewCell()
    var darkCell: UITableViewCell = UITableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        view.tintColor = .label
        self.navigationItem.title = "Appearance"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        self.tableView.isScrollEnabled = false
        self.tableView.separatorInset.left = 0
        self.tableView.tintColor = .label

        self.autoCell.textLabel?.text = "Auto"
        self.lightCell.textLabel?.text = "Light"
        self.darkCell.textLabel?.text = "Dark"
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureCell(for: theme, checked: true)
    }
    private var theme: Theme {
        get {
            return defaults.theme
        }
        set {
            defaults.theme = newValue
            configureStyle(for: newValue)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.autoCell
            case 1: return self.lightCell
            case 2: return self.darkCell
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != theme.rawValue {
            configureCell(for: theme, checked: false)
            theme = Theme(rawValue: indexPath.row) ?? .device
            configureCell(for: theme, checked: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    private func configureCell(for theme: Theme, checked: Bool) {
        let cell = tableView.cellForRow(at: IndexPath(row: theme.rawValue, section: 0))
        cell?.accessoryType = checked ? .checkmark : .none
    }
    private func configureStyle(for theme: Theme) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}
enum Theme: Int {
    case device
    case light
    case dark
}
extension Theme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
extension UserDefaults {
    var theme: Theme {
        get {
            register(defaults: [#function: Theme.device.rawValue])
            return Theme(rawValue: integer(forKey: #function)) ?? .device
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
