//
//  TestTinder.swift
//  Enhance
//
//  Created by Michael Gillund on 10/7/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class EnhanceTabBar: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {
    
    enum Tab: String, CaseIterable {
        case bell
        case home
        case settings
    }
    
    private let tabItems = Tab.allCases.map({ BarItem(for: $0) })
    private lazy var viewControllers = tabItems.compactMap({ $0.makeViewController() })
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        dataSource = self
        isScrollEnabled = true
        
        addBar(EnhanceBar.make(), dataSource: self, at: .bottom)
        
    }
    
    // MARK: PageboyViewControllerDataSource
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: 1)
    }
    
    // MARK: TMBarDataSource
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return tabItems[index]
    }
}

private class BarItem: TMBarItemable {
    
    let tab: EnhanceTabBar.Tab
    
    init(for tab: EnhanceTabBar.Tab) {
        self.tab = tab
    }
    
    private var _title: String? {
        return tab.rawValue.capitalized
    }
    var title: String? {
        get {
            return _title
        } set {}
    }
    
    private var _image: UIImage? {
        print(tab.rawValue)
        return UIImage(named: "\(tab.rawValue)")
    }
    var image: UIImage? {
        get {
            return _image
        } set {}
    }
    
    var badgeValue: String?
    
    func makeViewController() -> UIViewController? {
        var viewControllers = UIViewController()
        switch tab {
        case .bell:
            viewControllers = UINavigationController(rootViewController: SupremeMonitor())
        case .home:
            viewControllers = UINavigationController(rootViewController: Tasks())
        case .settings:
            viewControllers = UINavigationController(rootViewController: Settings())
        }
        return viewControllers
    }
}
