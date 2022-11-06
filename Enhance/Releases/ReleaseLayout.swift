//
//  ReleaseLayout.swift
//  Enhance
//
//  Created by Michael Gillund on 7/29/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

public class ReleaseLayout: FloatingPanelLayout {

    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.tip, .half]
    }

    public var initialPosition: FloatingPanelPosition {
        return .half
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 0
        case .half: return 265.0
        case .tip: return 65.0
        case .hidden: return nil
        }
    }

    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }

}
