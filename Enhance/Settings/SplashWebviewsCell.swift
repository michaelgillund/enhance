//
//  SplashWebviewsCell.swift
//  Enhance
//
//  Created by Michael Gillund on 10/21/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class SplashWebviewsCell: UICollectionViewCell, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(webView)
                
            NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.evaluateJavaScript( "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.5, maximum-scale=0.5, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);", completionHandler: nil)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
