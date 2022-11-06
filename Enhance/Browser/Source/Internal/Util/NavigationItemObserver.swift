//
//  NavigationItemObserver.swift
//  Enhance
//
//  Created by Michael Gillund on 12/1/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

/// Monitor class for bar button items and title of a navigation item.
/// Calls its provided block when a change is detected.
class NavigationItemObserver {
    weak var navigationItem: UINavigationItem?
    private var observations: [NSKeyValueObservation] = []

    init(navigationItem: UINavigationItem, _ changeHandler: @escaping () -> Void) {
        self.navigationItem = navigationItem

        observations = [
            navigationItem.observe(\UINavigationItem.leftBarButtonItem, changeHandler: { _, _ in changeHandler() }),
            navigationItem.observe(\UINavigationItem.rightBarButtonItem, changeHandler: { _, _ in changeHandler() }),
            navigationItem.observe(\UINavigationItem.leftBarButtonItems, changeHandler: { _, _ in changeHandler() }),
            navigationItem.observe(\UINavigationItem.rightBarButtonItems, changeHandler: { _, _ in changeHandler() }),
            navigationItem.observe(\UINavigationItem.title, changeHandler: { _, _ in changeHandler() })
        ]
    }

}
