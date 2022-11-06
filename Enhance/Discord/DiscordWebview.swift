//
//  DiscordWebview.swift
//  Enhance
//
//  Created by Michael Gillund on 5/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKUIDelegate, WKScriptMessageHandler {

    var webView: WKWebView!
    var urlPath: String = ""
        
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        loadWebView()
        items()
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    func items(){
        var items = [UIBarButtonItem]()
        
        items.append(
            UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .done, target: self, action: #selector(reload(_:)))
        )
        items.append(
            UIBarButtonItem(image:UIImage(systemName: "chevron.right"), style: .done, target: self, action: #selector(forward(_:)))
        )
        items.append(
            UIBarButtonItem(image:UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(back(_:)))
        )
        self.navigationItem.rightBarButtonItems = items
    }
    
    func loadWebView()
    {
        if let url = URL(string: urlPath)
        {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.large
            view.addSubview(activityIndicator)
            
//            var js: String!
//            do {
//                js = try String(contentsOfFile: Bundle.main.path(forResource: "autofill", ofType: "js")!)
//                let expiryDate = (cardExpirationDateKey3 ?? "").components(separatedBy: "/")
//                let store = [
//                    "selectedProfile": "profile3",
//                    "profiles": [[
//                        "profileName": "profile3",
//                        "cardholderName": cardNameKey3,
//                        "firstName": firstNameKey3,
//                        "lastName": lastNameKey3,
//                        "email": emailKey3,
//                        "phoneNumber": phoneNumberKey3,
//                        "address": addressline1Key3,
//                        "address2": addressline2Key3,
//                        "address3": addressline3Key3,
//                        "city": cityKey3,
//                        "state": stateKey3,
//                        "country": countryKey3,
//                        "zipcode": postalCodeKey3,
//                        "cardNumber": cardNumberKey3,
//                        "expiryMonth": expiryDate.first ?? "",
//                        "expiryYear": expiryDate.last ?? "",
//                        "cvv": cardCVCKey3
//                    ]],
//                    "settings": [
//                        "global": true,
//                        "autoCheckout": false,
//                        "stripe": true,
//                        "shopify": true,
//                        "supreme": false
//                    ]
//                ] as [String : Any]
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: store, options: .prettyPrinted)
//                    let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
//                    js = "const store = " + jsonString + ";" + js
//                } catch {
//                    print(error.localizedDescription)
//                }
//            } catch {
//                return
//            }
            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true
            preferences.javaScriptCanOpenWindowsAutomatically = true
            
            let config = WKWebViewConfiguration()
//            let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
//            config.userContentController.addUserScript(script)
            config.userContentController.add(self, name: "clickListener")
            config.userContentController.add(self, name: "messageHandler")
            config.preferences = preferences
            
            webView = WKWebView(frame: view.bounds, configuration: config)
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            webView.uiDelegate = self
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
            view = webView
            
            webView.navigationDelegate = self
            
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        return
    }
    func showActivityIndicator(show: Bool)
    {
       if show
       {
          activityIndicator.startAnimating()
       }
       else
       {
          activityIndicator.stopAnimating() // 23506-23328
       }
    }
    
    @objc func reload(_ sender: Any) {
        webView.reload()
    }
    @objc func back(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    @objc func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
}

extension WebViewVC: WKNavigationDelegate
{
   func webView(_ myWebView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
       
        // print("1. The web content is loaded in the WebView.\n")
        showActivityIndicator(show: true)
    }
    
    func webView(_ myWebView: WKWebView, didCommit navigation: WKNavigation!) {
        
        // print("2. The WebView begins to receive web content.\n")
    }
    
    func webView(_ myWebView: WKWebView, didFinish navigation: WKNavigation!)
    {
        print("3. The didFinish navigation to url \(myWebView.url!) \n")
        showActivityIndicator(show: false)
    }
        
    func webViewWebContentProcessDidTerminate(_ myWebView: WKWebView)
    {
        // print("The Web Content Process is finished.\n")
    }
    
    func webView(_ myWebView: WKWebView, didFail navigation: WKNavigation!, withError: Error)
    {
        print("An error didFail occured.....", withError.localizedDescription)
        showActivityIndicator(show: false)
    }
    
    func webView(_ myWebView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError: Error)
    {
        print("An error didFailProvisionalNavigation occured.\n....", withError.localizedDescription)
        showActivityIndicator(show: false)
    }
}

   
    

