
import UIKit
import WebKit

class ShopifyWebView: UIViewController, UISearchBarDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate, UISearchControllerDelegate{
       
    var cardElements: [String] = []
    var observingCardElements = false
    var runningObserver = false
    
    var webView: WKWebView!
    var popupWebView: WKWebView?
    var urlPath: String = "https://google.com"

    let searchBar = UISearchBar()
    
    private var shadowImageView: UIImageView?
    var profiles = Profiles()
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationController?.toolbar.tintColor = .label

        setupWebView()
        loadWebView()
        toolBar()

        searchBar.barTintColor = .label
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        if let profiles = Preferences.shared.profiles {
            self.profiles = profiles
        }
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

//        self.navigationController?.isToolbarHidden = true
//        self.navigationController?.hidesBarsOnSwipe = false

        shadowImageView?.isHidden = true

//        self.navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
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
        var js: String!
        do {
            js = try String(contentsOfFile: Bundle.main.path(forResource: "autofill", ofType: "js")!)
            let store = [
                "selectedProfile": "profile1",
                "profiles": [[
                    "profileName": "profile1",
                    "cardholderName": "John Doe",
                    "firstName": "John",
                    "lastName": "Doe",
                    "email": "johndoe@gamil.com",
                    "phoneNumber": "3124325332",
                    "address": "123 test street",
                    "address2": "",
                    "address3": "",
                    "city": "los angeles",
                    "state": "CA",
                    "country": "USA",
                    "zipcode": "12341",
                    "cardNumber": "1234123412341234",
                    "expiryMonth": "03",
                    "expiryYear": "24",
                    "cvv": "123"
                ]],
                "settings": [
                    "global": true,
                    "autoCheckout": false,
                    "stripe": true,
                    "shopify": true,
                    "supreme": false
                ]
            ] as [String : Any]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: store, options: .prettyPrinted)
                let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
                js = "const store = " + jsonString + ";" + js
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            return
        }
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let config = WKWebViewConfiguration()
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(script)
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
    
            
    @objc func back(_ sender: Any) {
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
    @objc func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    @objc func reload(_ sender: Any) {
        webView.reload()
        popupWebView?.reload()
    }
}
