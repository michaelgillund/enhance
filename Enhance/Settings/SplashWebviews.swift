//
//  SplashWebviews.swift
//  Enhance
//
//  Created by Michael Gillund on 10/21/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class SplashWebviews: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, WKNavigationDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()

    var webViews: [WKWebView] = []
    var searchText: String?
    var numberOfItems = 0
    
    let searchController = UISearchController(searchResultsController: nil)
    let plusButton = UIButton(type: .system)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Splash"
        

        collectionView.register(SplashWebviewsCell.self, forCellWithReuseIdentifier: "SplashWebviewsCell")
        collectionView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        collectionView.dataSource = self
        collectionView.delegate = self
    
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.keyboardType = .URL
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        
        plusBtn()
        constraints()
    }
    func constraints(){
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
    }
    
    func plusBtn(){
        let xImage = UIImage(systemName: "plus")?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .heavy))
        plusButton.setImage(xImage, for: .normal)
        
        let barItem = UIBarButtonItem(customView: plusButton)
        navigationItem.rightBarButtonItem = barItem
        
        plusButton.addTarget(self, action: #selector(addBtn), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.backgroundColor = UIColor.label.withAlphaComponent(0.7)
        plusButton.layer.cornerRadius = 20
        plusButton.tintColor = UIColor.systemBackground.withAlphaComponent(0.7)

        NSLayoutConstraint.activate([
        plusButton.widthAnchor.constraint(equalToConstant: 40),
        plusButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func addBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SQMarket-Medium", size: 20.0)!]

        let titleAttrString = NSMutableAttributedString(string: "Add Tasks", attributes: titleFont)

        alert.setValue(titleAttrString, forKey: "attributedTitle")
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.view.tintColor = .systemGray
        

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Qty"
            textField.borderStyle = .none
            textField.keyboardType = .numberPad
        })

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in

        if let qty = alert.textFields?.first?.text {
            let string = "\(qty)"
            let int = Int(string)
            self.numberOfItems += (int!)
            self.collectionView.reloadData()
            }
        }))

        self.present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SplashWebviewsCell", for: indexPath) as? SplashWebviewsCell else { return UICollectionViewCell()}

            cell.webView.removeFromSuperview()
            if indexPath.row+1 > webViews.count {

                let webView = WKWebView(frame: cell.contentView.bounds)
                webViews.append(webView)
                        
                let url = URL(string: self.searchText ?? "https://yeezysupply.com")
                let request = URLRequest(url: url!)


                DispatchQueue.main.async {
                    cell.contentView.addSubview(webView)
                    cell.contentView.sendSubviewToBack(webView)
                    cell.webView = self.webViews[indexPath.row]
                    cell.webView.load(request)
                    cell.webView.frame = cell.contentView.frame
                }
            }else {
                let webView = webViews[indexPath.row]
                DispatchQueue.main.async {
                    cell.contentView.addSubview(webView)
                    cell.contentView.sendSubviewToBack(webView)
                    cell.webView = webView
                    cell.webView.frame = cell.contentView.frame
                }
            }
            cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    func searchBarSearchButtonClicked(_ search: UISearchBar) {
            
        self.searchController.searchBar.resignFirstResponder()

        self.searchController.searchBar.endEditing(true)
        self.searchText = searchController.searchBar.text
            
        let urlStr =  searchController.searchBar.text!

        let url = NSURL(string: urlStr)
        let req = NSURLRequest(url:url! as URL)

        for webView in webViews {
                webView.load(req as URLRequest)
        }
    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        for webView in webViews {
//            webView.evaluateJavaScript( "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.5, maximum-scale=0.5, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);", completionHandler: nil)
//        }
//
//    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if keyPath == "estimatedProgress" {
            for webView in webViews{
                self.searchController.searchBar.text = webView.url?.absoluteString
            }
        }
    }
}
