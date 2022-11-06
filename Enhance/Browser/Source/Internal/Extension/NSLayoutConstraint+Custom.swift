//
//  NSLayoutConstraint+Custom.swift
//  Enhance
//
//  Created by Michael Gillund on 12/1/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit

public extension NSLayoutConstraint {

    /// Add a priority to an existing constraint.
    /// Useful when creating and setting at the same time:
    ///    self.constraint = self.widthAnchor.constraint(equalToConstant: 0).withPriority(.defaultHigh)
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
