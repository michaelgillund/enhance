//
//  Login.swift
//  Enhance
//
//  Created by Michael Gillund on 4/27/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit
import Lottie
import SafariServices

class Login: UIViewController, WKNavigationDelegate, WKUIDelegate, SFSafariViewControllerDelegate {
    
    struct Code: Codable {
        let code: String
    }
    
    var webView: WKWebView!
    var webViewURLObserver: NSKeyValueObservation?
    var codeParam: URLQueryItem?
    var urlPath: String = "https://discordapp.com/api/oauth2/authorize?client_id=706532900048207924&redirect_uri=https%3A%2F%2Fdashboard.sneakersquad.co&response_type=code&scope=identify%20email%20guilds"
    
    let dateFormatter = DateFormatter()
    let defaults = UserDefaults.standard
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"Logo.png")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
        button.cornerRadius = 5
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.layer.shadowOpacity = 0.50
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00).cgColor
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ssZZZ"
        let lastLogin = defaults.string(forKey: "lastLogin")
        if (lastLogin != nil && Date() < dateFormatter.date(from: lastLogin!)!.addingTimeInterval(864000)) {
            startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.00) {
                self.constraints()
            }
        } else {
//            setupWebView()
//            loadWebView()
            constraints()
            
//            let urlString = "https://discordapp.com/api/oauth2/authorize?client_id=706532900048207924&redirect_uri=https%3A%2F%2Fdashboard.sneakersquad.co&response_type=code&scope=identify%20email%20guilds"
//            if let url = URL(string: urlString) {
//                let safari = SFSafariViewController(url: url)
//                safari.delegate = self
//                safari.modalPresentationStyle = UIModalPresentationStyle.popover
//                present(safari, animated: true, completion: nil)
//            }
        }
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    @objc func login(){
//        let login = Login()
//        self.navigationController?.pushViewController(login, animated: true)
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        let url = URL(string: "https://www.hackingwithswift.com")!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
//        view = webView
        setupWebView()
        loadWebView()
        
    }
    func constraints(){
        view.addSubview(imageView)
        view.addSubview(loginButton)
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.rotate360Degrees()
        
//        loginButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        loginButton.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    func startAnimation(){
        let loader =  AnimationView(name: "loading")
        view.contentMode = .center
        self.view.addSubview(loader)
        loader.frame = self.view.bounds
        loader.loopMode = .loop
        loader.play()
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
        
        view.addSubview(webView)
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
    }
    func loadWebView() {
        if let url = URL(string: urlPath) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if let key = change?[NSKeyValueChangeKey.newKey] {
            print("URL: \(key)")
            
            let components = URLComponents(url: key as! URL, resolvingAgainstBaseURL: false)
            print("COMPONETS: \(String(describing: components?.queryItems))")

            if let queryItems = components?.queryItems {
              codeParam = queryItems.first { $0.name == "code" }
            }

            guard let param = codeParam else { return }
            guard let value = param.value else { return }
            print("VALUE \(value)")

            let order = Code(code: "\(value)")
            guard let uploadData = try? JSONEncoder().encode(order) else {
                return
            }
            print("ORDER: \(order)")
            print("UPLOAD DATA: \(uploadData)")
            let url = URL(string: "http://thatoneawkwardguy.io:5001/api/auth")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            // Perform HTTP Request
            let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in

                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }

                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("RESPONSE DATA STRING: \(dataString)")

                    if dataString == "true"{
                    DispatchQueue.main.async {
                        self.defaults.set(self.dateFormatter.string(from: Date()), forKey: "lastLogin")
                        self.dismiss(animated: true, completion: nil)
//                        self.performSegue(withIdentifier: "dashboard", sender: self)
                        }
                    }else{
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "AUTH ERROR", message: "https://discord.gg/Kfx9NQ", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        task.resume()
    }
}
    func run() {
        let navigationController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation") as UIViewController
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
    }
}

extension UIView {
     func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration

        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
