//
//  TinderBar.swift
//  Tinderbar
//
//  Created by Merrick Sapsford on 22/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Tabman

class EnhanceBar {
    
    typealias BarType = TMBarView<EnhanceBarLayout, EnhanceBarButton, TMBarIndicator.None>
    
    static func make() -> TMBar {
        let bar = BarType()
        
        bar.scrollMode = .swipe
        
        bar.buttons.customize { (button) in
            button.tintColor = EnhanceColors.primaryTint
            button.unselectedTintColor = EnhanceColors.unselectedGray
        }
        
        // Wrap in a 'navigation bar'.
        let navigationBar = bar.systemBar()
        navigationBar.backgroundStyle = .flat(color: UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00))
        navigationBar.separatorColor = .clear
        return navigationBar
    }
}
