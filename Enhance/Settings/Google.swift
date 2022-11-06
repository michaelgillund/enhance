//
//  Google.swift
//  Enhance
//
//  Created by Michael Gillund on 8/24/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class Google: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var activity: UIActivityIndicatorView?
    var webView: WKWebView!
    var urlPath: String = "https://accounts.google.com/signin/v2/identifier?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin"

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.toolbar.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Captcha.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(captcha))

        setupWebView()
        loadWebView()
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    func setupWebView() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let config = WKWebViewConfiguration()
        config.preferences = preferences

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    func loadWebView() {
        let url = URL(string: urlPath)
        var request = URLRequest(url: url!)
        request.httpShouldHandleCookies = true
        webView.load(request)
    }
    func showActivityIndicator() {
        activity = UIActivityIndicatorView(style: .large)
        activity?.center = self.view.center
        self.view.addSubview(activity!)
        activity?.startAnimating()
    }
    func hideActivityIndicator() {
        if (activity != nil){
            activity?.stopAnimating()
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        hideActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideActivityIndicator()
    }
    @objc func captcha(_ sender: Any){
        let captcha = Captcha()
        self.navigationController?.pushViewController(captcha, animated: true)
    }
}
class Captcha: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var activity: UIActivityIndicatorView?
    var webView: WKWebView!
    var urlPath: String = "https://www.google.com/recaptcha/api2/demo"

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.toolbar.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        setupWebView()
        loadWebView()
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    func setupWebView() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let config = WKWebViewConfiguration()
        config.preferences = preferences

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    func loadWebView() {
        let url = URL(string: urlPath)
        var request = URLRequest(url: url!)
        request.httpShouldHandleCookies = true
        webView.load(request)
    }
    func showActivityIndicator() {
        activity = UIActivityIndicatorView(style: .large)
        activity?.center = self.view.center
        self.view.addSubview(activity!)
        activity?.startAnimating()
    }
    func hideActivityIndicator() {
        if (activity != nil){
            activity?.stopAnimating()
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        hideActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideActivityIndicator()
    }
    @objc func done(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}
