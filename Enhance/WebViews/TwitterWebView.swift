//
//  TwitterWebView.swift
//  Enhance
//
//  Created by Michael Gillund on 6/9/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class TwitterWebView: UIViewController, UISearchBarDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate, UISearchControllerDelegate{
       
    var cardElements: [String] = []
    var observingCardElements = false
    var runningObserver = false
    
    var webView: WKWebView!
    var popupWebView: WKWebView?
    var urlPath: String = "https://portal.paradoxnotify.com/"

    let searchBar = UISearchBar()
    
    private var shadowImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loadCookie()
        
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.toolbar.tintColor = .label
        
        setupWebView()
        loadWebView()
        toolBar()
        
        searchBar.barTintColor = .label
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.isToolbarHidden = false
//        self.navigationController?.hidesBarsOnSwipe = true

        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true

//        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//
//        self.navigationController?.isToolbarHidden = true
//        self.navigationController?.hidesBarsOnSwipe = false
        
        shadowImageView?.isHidden = true

//        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        saveCookie()
    }
    func toolBar(){
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        let fixedSpace5: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace5.width = 5.0
        let fixedSpace20: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace20.width = 20.0
        items.append(fixedSpace5)
        items.append(UIBarButtonItem(image:UIImage(systemName: "chevron.left"), style: .done, target: nil, action: #selector(back(_:))))
        items.append(fixedSpace20)
        items.append(UIBarButtonItem(image:UIImage(systemName: "chevron.right"), style: .done, target: self, action: #selector(forward(_:))))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .done, target: self, action: #selector(reload(_:))))
        items.append(fixedSpace5)
        self.toolbarItems = items
    }
    //CLEAR BOTTOM NAV BAR LINE
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }

        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }

    func setupWebView() {
//        var js: String!
//        do {
//            js = try String(contentsOfFile: Bundle.main.path(forResource: "autofill", ofType: "js")!)
//            let expiryDate = (cardExpirationDateKey2 ?? "").components(separatedBy: "/")
//            let store = [
//                "selectedProfile": "profile2",
//                "profiles": [[
//                    "profileName": "profile2",
//                    "cardholderName": cardNameKey2,
//                    "firstName": firstNameKey2,
//                    "lastName": lastNameKey2,
//                    "email": emailKey2,
//                    "phoneNumber": phoneNumberKey2,
//                    "address": addressline1Key2,
//                    "address2": addressline2Key2,
//                    "address3": addressline3Key2,
//                    "city": cityKey2,
//                    "state": stateKey2,
//                    "country": countryKey2,
//                    "zipcode": postalCodeKey2,
//                    "cardNumber": cardNumberKey2,
//                    "expiryMonth": expiryDate.first ?? "",
//                    "expiryYear": expiryDate.last ?? "",
//                    "cvv": cardCVCKey2
//                ]],
//                "settings": [
//                    "global": true,
//                    "autoCheckout": false,
//                    "stripe": true,
//                    "shopify": true,
//                    "supreme": false
//                ]
//            ] as [String : Any]
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: store, options: .prettyPrinted)
//                let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
//                js = "const store = " + jsonString + ";" + js
//            } catch {
//                print(error.localizedDescription)
//            }
//        } catch {
//            return
//        }
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let config = WKWebViewConfiguration()
//        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
//        config.userContentController.addUserScript(script)
        config.userContentController.add(self, name: "clickListener")
        config.userContentController.add(self, name: "messageHandler")
        config.preferences = preferences

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
 
    func loadWebView() {
        let url = URL(string: urlPath)
        var request = URLRequest(url: url!)
        request.httpShouldHandleCookies = true
        webView.load(request)
    }
    func saveCookie() {
        let cookieJar: HTTPCookieStorage = HTTPCookieStorage.shared
        if let cookies = cookieJar.cookies {
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: cookies)
            let ud: UserDefaults = UserDefaults.standard
            ud.set(data, forKey: "cookie")
        }
    }

    func loadCookie() {
        let ud: UserDefaults = UserDefaults.standard
        let data: Data? = ud.object(forKey: "cookie") as? Data
        if let cookie = data {
            let datas: NSArray? = NSKeyedUnarchiver.unarchiveObject(with: cookie) as? NSArray
            if let cookies = datas {
                for c in cookies {
                    if let cookieObject = c as? HTTPCookie {
                        HTTPCookieStorage.shared.setCookie(cookieObject)
                    }
                }
            }
        }
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
           popupWebView = WKWebView(frame: view.bounds, configuration: configuration)
           popupWebView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           popupWebView!.navigationDelegate = self
           popupWebView!.uiDelegate = self
           view.addSubview(popupWebView!)
           return popupWebView!
       }

    func webViewDidClose(_ webView: WKWebView) {
        if webView == popupWebView {
           popupWebView?.removeFromSuperview()
           popupWebView = nil
        }
    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        if (webView.url?.absoluteString.contains("https://www.supremenewyork.com/mobile"))!{
//            print("SUCCESS")
//            }
//    }

//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        if let frame = navigationAction.targetFrame, frame.isMainFrame{
//            return nil
//        }
//        webView.load(navigationAction.request)
//        return nil
//    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let urlStr = searchBar.text!

        let url = NSURL(string: urlStr)
        let req = NSURLRequest(url:url! as URL)
        self.webView!.load(req as URLRequest)
//        self.popupWebView!.load(req as URLRequest)

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if keyPath == "estimatedProgress" {
            searchBar.text = webView.url?.absoluteString
        }
    }
            
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        return
    }
            
    func tryUrl(string: String) -> URL? {
        guard let url = URL(string: string) else { return nil }
        if UIApplication.shared.canOpenURL(url) {
            return url
        }
        return nil
    }
    
            
    @IBAction func back(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
            popupWebView?.goBack()
        }else{
        popupWebView?.removeFromSuperview()
        }
//        if popupWebView!.canGoBack{
////            popupWebView?.goBack()
//            popupWebView?.removeFromSuperview()
//        }else{
//            webView.goBack()
//        }

    }
    @IBAction func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    @IBAction func reload(_ sender: Any) {
        webView.reload()
        popupWebView?.reload()
    }
}
