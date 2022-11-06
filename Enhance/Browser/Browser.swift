//
//  Browser.swift
//  Enhance
//
//  Created by Michael Gillund on 12/1/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
//import UIKit
//import TabView
//
//class Browser: TabViewController {
//    let plusButton = UIButton(type: .system)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.isModalInPresentation = true
//        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//
//        self.title = "Browser"
//
//        let exitButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(exit))
//        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addTab))
//        navigationItem.leftBarButtonItem = exitButton
//        navigationItem.rightBarButtonItem = addButton
//        self.viewControllers = [
//            Tab(title: "\(viewControllers.count + 1)"),
//        ]
//
//    }
//    @objc private func addTab() {
//        self.activateTab(Tab(title: "\(viewControllers.count + 1)"))
//    }
//    @objc func exit(_ sender: Any){
//        dismiss(animated: true, completion: nil)
//    }
//
//}
//import WebKit
//private class Tab: UIViewController, WKNavigationDelegate {
//
//    init(title: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.title = title
//    }
//
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    var webView: WKWebView!
//
//    let views = UIView()
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
////        view = webView
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        views.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//        view = views
//        let search = UISearchBar()
//        search.searchBarStyle = .minimal
//        search.translatesAutoresizingMaskIntoConstraints = false
//        views.addSubview(webView)
//        views.addSubview(search)
//
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//
//        search.bottomAnchor.constraint(equalTo: webView.topAnchor, constant: 0).isActive = true
//
//        webView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 0).isActive = true
//        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//
//        let url = URL(string: "https://www.yeezysupply.com")!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
//
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript( "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.5, maximum-scale=0.5, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);", completionHandler: nil)
//    }
//
//}
//
