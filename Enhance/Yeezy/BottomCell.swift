//
//  BottomCell.swift
//  Enhance
//
//  Created by Michael Gillund on 5/19/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class BottomCollectionViewCell: UICollectionViewCell {

    var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(webView)
        webView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        webView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func reload(_ sender: Any) {
        webView.reload()
    }
    @objc func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    @objc func back(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
}
