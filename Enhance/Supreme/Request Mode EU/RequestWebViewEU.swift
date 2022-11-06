//
//  RequestWebViewEU.swift
//  Enhance
//
//  Created by Michael Gillund on 7/6/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class RequestWebViewEU: UIViewController, WKNavigationDelegate {

    //Variables
    var supremeBrowser: WKWebView?
    var supremeBot: SupremeEU?
    let defaults = UserDefaults.standard
    var botRunning:Bool = false
    
    //Objects

    let powerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialize Bot
        self.supremeBot = SupremeEU(withViewController: self)

        //Setup browser
        createSupremeBrowser()
        powerBtn()
    }
    func powerBtn(){
        let xImage = UIImage(systemName: "play")?.applyingSymbolConfiguration(.init(pointSize: 14, weight: .heavy))
        powerButton.setImage(xImage, for: .normal)
        
        let barItem = UIBarButtonItem(customView: powerButton)
        navigationItem.rightBarButtonItem = barItem
        
        powerButton.addTarget(self, action: #selector(run), for: .touchUpInside)
        powerButton.translatesAutoresizingMaskIntoConstraints = false
        powerButton.backgroundColor = UIColor.label.withAlphaComponent(0.7)
        powerButton.layer.cornerRadius = 15
        powerButton.tintColor = UIColor.systemBackground.withAlphaComponent(0.7)

        NSLayoutConstraint.activate([
            powerButton.widthAnchor.constraint(equalToConstant: 30),
            powerButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    //Setup the webview
    func createSupremeBrowser()
    {
        //Create webview and add to the container view
        supremeBrowser = WKWebView()
        view.addSubview(supremeBrowser!)
        
        //Setup the frame so it displays correctly
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        supremeBrowser!.frame = frame
        
        //Load the URL
        self.supremeBrowser!.load(URLRequest(url: URL(string: "https://www.supremenewyork.com/mobile/#categories")!))
        self.supremeBrowser?.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
    }


    @objc func run(_ sender: Any) {
        if (botRunning == false){
            supremeBot?.startProcess()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
            supremeBot?.pasteInfo()
    }
    
    @IBAction func home(_ sender: Any) {
        self.supremeBrowser!.load(URLRequest(url: URL(string: "https://www.supremenewyork.com/mobile/#categories")!))
    }
    @IBAction func google(_ sender: Any) {
        self.supremeBrowser!.load(URLRequest(url: URL(string: "https://accounts.google.com/signin/v2/identifier?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin")!))
    }
    
}



