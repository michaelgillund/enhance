//
//  Splash.swift
//  Enhance
//
//  Created by Michael Gillund on 10/8/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class Splash: UIViewController, WKNavigationDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        
        self.navigationItem.title = "Splash"
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(close))
        let massLinkButton = UIBarButtonItem(image: UIImage(systemName: "link"), style: .done, target: self, action: #selector(massLink))
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = massLinkButton

        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(SplashView())
        scrollViewContainer.addArrangedSubview(SplashView())
        scrollViewContainer.addArrangedSubview(SplashView())
        scrollViewContainer.addArrangedSubview(SplashView())
        scrollViewContainer.addArrangedSubview(SplashView())

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        

    }
    @objc func close(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    @objc func massLink(_ sender: Any){
        let alert = UIAlertController(title: "Mass Link Chnage", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = .systemGray
        

        alert.addTextField { (textField) in
            textField.placeholder = "Enter Url:"
            textField.borderStyle = .none
            textField.keyboardType = .URL
        }

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in

        if let url = alert.textFields?.first?.text {
            let string = "\(url)"
            let vc = SplashView()
            vc.newURL = url
            print(vc.newURL)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newLink"), object: nil)

            }
        }))

        self.present(alert, animated: true)
    }
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}

class SplashView: UIView, WKNavigationDelegate, UISearchBarDelegate, WKScriptMessageHandler {

    var webView1: WKWebView!
    var webView2: WKWebView!
    var profiles = Profiles()
    var newURL : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(newLink), name:NSNotification.Name(rawValue: "newLink"), object: nil)
    }
    @objc func newLink() {
        guard let newURL = newURL else { return }
        let url = URL(string: "\(newURL)")
        
        webView1.load(URLRequest(url: url!))
        webView2.load(URLRequest(url: url!))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
  
    private func setupView() {
        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        if let profiles = Preferences.shared.profiles {
            self.profiles = profiles
        }
//        print("PROFILE ARRAY:", self.profiles.profileList)
        
//        var js: String!
//        do {
//            js = try String(contentsOfFile: Bundle.main.path(forResource: "autofill", ofType: "js")!)
//            let expiryDate = (cardExpirationDateKey ?? "").components(separatedBy: "/")
//            let store = [
//                "selectedProfile": "profile1",
//                "profiles": [[
//                    "profileName": "profile1",
//                    "cardholderName": cardNameKey,
//                    "firstName": firstNameKey,
//                    "lastName": lastNameKey,
//                    "email": emailKey,
//                    "phoneNumber": phoneNumberKey,
//                    "address": addressline1Key,
//                    "address2": addressline2Key,
//                    "address3": addressline3Key,
//                    "city": cityKey,
//                    "state": stateKey,
//                    "country": countryKey,
//                    "zipcode": postalCodeKey,
//                    "cardNumber": cardNumberKey,
//                    "expiryMonth": expiryDate.first ?? "",
//                    "expiryYear": expiryDate.last ?? "",
//                    "cvv": cardCVCKey
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

        webView1 = WKWebView(frame: .zero, configuration: config)
        webView2 = WKWebView(frame: .zero, configuration: config)
         
        webView1.navigationDelegate = self
        webView2.navigationDelegate = self

        webView1.translatesAutoresizingMaskIntoConstraints = false
        webView2.translatesAutoresizingMaskIntoConstraints = false
        
        webView1.layer.cornerRadius = 5
        webView1.layer.masksToBounds = true
        webView1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        webView2.layer.cornerRadius = 5
        webView2.layer.masksToBounds = true
        webView2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.addSubview(webView1)
        self.addSubview(view_1)
        view_1.addSubview(button1_1)
        view_1.addSubview(button2_1)
        view_1.addSubview(button3_1)
//        insertSubview(button1_1, aboveSubview: view_1)
//        insertSubview(button2_1, aboveSubview: webView1)
//        insertSubview(button3_1, aboveSubview: webView1)
        
        self.addSubview(webView2)
        self.addSubview(view_2)
        view_2.addSubview(button1_2)
        view_2.addSubview(button2_2)
        view_2.addSubview(button3_2)
//        insertSubview(button1_2, aboveSubview: webView2)
//        insertSubview(button2_2, aboveSubview: webView2)
//        insertSubview(button3_2, aboveSubview: webView2)

        setupLayout()
        
        let url = URL(string: "https://enhance-quick-links.carrd.co/")!
        
        webView1.load(URLRequest(url: url))
        webView2.load(URLRequest(url: url))

        webView1.allowsBackForwardNavigationGestures = true
        webView2.allowsBackForwardNavigationGestures = true

    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 400),
            
            webView1.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            webView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            webView1.trailingAnchor.constraint(equalTo: webView2.leadingAnchor, constant: -1),
//            webView1.bottomAnchor.constraint(equalTo: view_1.topAnchor, constant: 10),
            webView1.widthAnchor.constraint(equalToConstant: 171),
            webView1.heightAnchor.constraint(equalToConstant: 350),

            webView2.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            webView2.leadingAnchor.constraint(equalTo: webView1.trailingAnchor, constant: 1),
            webView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            webView2.bottomAnchor.constraint(equalTo: view_2.topAnchor, constant: 10),
            webView2.widthAnchor.constraint(equalToConstant: 171),
            webView2.heightAnchor.constraint(equalToConstant: 350),
            
            view_1.topAnchor.constraint(equalTo: webView1.bottomAnchor, constant: 0),
            view_1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            view_1.trailingAnchor.constraint(equalTo: view_2.leadingAnchor, constant: -1),
            view_1.heightAnchor.constraint(equalToConstant: 40),
            view_1.widthAnchor.constraint(equalToConstant: 171),

            view_2.topAnchor.constraint(equalTo: webView2.bottomAnchor, constant: 0),
            view_2.leadingAnchor.constraint(equalTo: view_1.trailingAnchor, constant: 1),
            view_2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            view_2.heightAnchor.constraint(equalToConstant: 40),
            view_2.widthAnchor.constraint(equalToConstant: 171),
            
            button1_1.topAnchor.constraint(equalTo: view_1.topAnchor, constant: 0),
            button1_1.leadingAnchor.constraint(equalTo: view_1.leadingAnchor, constant: 0),
//            button1_1.trailingAnchor.constraint(equalTo: button2_1.trailingAnchor, constant: 0),
            button1_1.bottomAnchor.constraint(equalTo: view_1.bottomAnchor, constant: 0),
            button1_1.heightAnchor.constraint(equalToConstant: 40),
            button1_1.widthAnchor.constraint(equalToConstant: 40),
            
            button3_1.centerXAnchor.constraint(equalTo: view_1.centerXAnchor),
            button3_1.centerYAnchor.constraint(equalTo: view_1.centerYAnchor),
            button3_1.heightAnchor.constraint(equalToConstant: 40),
            button3_1.widthAnchor.constraint(equalToConstant: 40),
            
            button2_1.topAnchor.constraint(equalTo: view_1.topAnchor, constant: 0),
//            button3_1.leadingAnchor.constraint(equalTo: view_1.leadingAnchor, constant: 0),
            button2_1.trailingAnchor.constraint(equalTo: view_1.trailingAnchor, constant: 0),
            button2_1.bottomAnchor.constraint(equalTo: view_1.bottomAnchor, constant: 0),
            button2_1.heightAnchor.constraint(equalToConstant: 40),
            button2_1.widthAnchor.constraint(equalToConstant: 40),
            
            button1_2.topAnchor.constraint(equalTo: view_2.topAnchor, constant: 0),
            button1_2.leadingAnchor.constraint(equalTo: view_2.leadingAnchor, constant: 0),
//            button1_1.trailingAnchor.constraint(equalTo: button2_1.trailingAnchor, constant: 0),
            button1_2.bottomAnchor.constraint(equalTo: view_2.bottomAnchor, constant: 0),
            button1_2.heightAnchor.constraint(equalToConstant: 40),
            button1_2.widthAnchor.constraint(equalToConstant: 40),
            
            button3_2.centerXAnchor.constraint(equalTo: view_2.centerXAnchor),
            button3_2.centerYAnchor.constraint(equalTo: view_2.centerYAnchor),
            button3_2.heightAnchor.constraint(equalToConstant: 40),
            button3_2.widthAnchor.constraint(equalToConstant: 40),
            
            button2_2.topAnchor.constraint(equalTo: view_2.topAnchor, constant: 0),
//            button3_1.leadingAnchor.constraint(equalTo: view_1.leadingAnchor, constant: 0),
            button2_2.trailingAnchor.constraint(equalTo: view_2.trailingAnchor, constant: 0),
            button2_2.bottomAnchor.constraint(equalTo: view_2.bottomAnchor, constant: 0),
            button2_2.heightAnchor.constraint(equalToConstant: 40),
            button2_2.widthAnchor.constraint(equalToConstant: 40),
                                    
        ])
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView1.evaluateJavaScript( "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.5, maximum-scale=0.5, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);", completionHandler: nil)
        webView2.evaluateJavaScript( "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.5, maximum-scale=0.5, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);", completionHandler: nil)

    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        return
    }
    let button1_1: UIButton = {
        let buttonFrame = CGRect(x: 20, y: 405, width: 25, height: 25)
        let button = UIButton()
        button.addTarget(self, action: #selector(back1_1), for: .touchUpInside)
        let image = UIImage(systemName: "chevron.left.circle")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let button2_1: UIButton = {
        let buttonFrame = CGRect(x: 50, y: 405, width: 25, height: 25)
        let button = UIButton()
        button.addTarget(self, action: #selector(forward1_1), for: .touchUpInside)
        let image = UIImage(systemName: "chevron.right.circle")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let button3_1: UIButton = {
        let buttonFrame = CGRect(x: 157, y: 405, width: 25, height: 25)
        let button = UIButton()
        button.addTarget(self, action: #selector(refresh1_1), for: .touchUpInside)
        let image = UIImage(systemName: "arrow.clockwise.circle")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func refresh1_1(){
        webView1.reload()
    }
    @objc func back1_1(){
        if webView1.canGoBack{
            webView1.goBack()
        }
    }
    @objc func forward1_1(){
        if webView1.canGoForward{
            webView1.goForward()
        }
    }
    let button1_2: UIButton = {
        let buttonFrame = CGRect(x: 193, y: 405, width: 25, height: 25)
        let button = UIButton()
        button.addTarget(self, action: #selector(back1_2), for: .touchUpInside)
        let image = UIImage(systemName: "chevron.left.circle")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let button2_2: UIButton = {
        let buttonFrame = CGRect(x: 223, y: 405, width: 25, height: 25)
        let button = UIButton()
        button.addTarget(self, action: #selector(forward1_2), for: .touchUpInside)
        let image = UIImage(systemName: "chevron.right.circle")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let button3_2: UIButton = {
        let buttonFrame = CGRect(x: 329, y: 405, width: 25, height: 25)
        let button = UIButton()
        button.addTarget(self, action: #selector(refresh1_2), for: .touchUpInside)
        let image = UIImage(systemName: "arrow.clockwise.circle")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .regular))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func refresh1_2(){
        webView2.reload()
    }
    @objc func back1_2(){
        if webView2.canGoBack{
            webView2.goBack()
        }
    }
    @objc func forward1_2(){
        if webView2.canGoForward{
            webView2.goForward()
        }
    }
    let view_1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
        view.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let view_2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
        view.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
