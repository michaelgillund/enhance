//
//  Testing 2.swift
//  Enhance
//
//  Created by Michael Gillund on 10/3/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class Testing_2: TabmanViewController {

    private var viewControllers = [web(),web()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
//        self.navigationItem.title = "Tasks"
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(add))

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .progressive // Customize
        addBar(bar, dataSource: self, at: .top)
    }
    @objc func add(){
        self.viewControllers.append(web())
        
    }


}
extension Testing_2: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = "   \(index + 1)   "
        return TMBarItem(title: title)
    }
}
import WebKit
class web: UIViewController, WKNavigationDelegate{
//    var webView: WKWebView!
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    let views = UIView()
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        view.addSubview(views)
////        views.translatesAutoresizingMaskIntoConstraints = false
////        views.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
////        views.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
////        views.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//////        views.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
////        views.heightAnchor.constraint(equalToConstant: 300).isActive = true
////        views.backgroundColor = .darkGray
////        view = views
////        
////        views.addSubview(webView)
////        webView.translatesAutoresizingMaskIntoConstraints = false
////        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
////        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
////        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
////        webView.heightAnchor.constraint(equalToConstant: 600).isActive = true
////        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
////
//        let url = URL(string: "https://www.yeezysupply.com")!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
//        
////        webView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//
////        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
////        tableView.tableFooterView = UIView()
//    }
}
