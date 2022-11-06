//
//  SplashCollectionView.swift
//  Enhance
//
//  Created by Michael Gillund on 5/19/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import WebKit

class Yeezy: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    lazy var webViewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        return collection
    }()
    lazy var selectorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()


    var webViews: [WKWebView] = []
    var searchText: String?
    var numberOfItems = 0
    var c: BottomCollectionViewCell!
    var modelData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10","11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]
    
    let searchController = UISearchController(searchResultsController: nil)
    let plusButton = UIButton(type: .system)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Yeezy"
        
        selectorCollectionView.identifier = .top
        selectorCollectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: "buttonCell")
        selectorCollectionView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        selectorCollectionView.dataSource = self
        selectorCollectionView.delegate = self
        
        webViewCollectionView.identifier = .bottom
        webViewCollectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: "bottomCollectionViewCell")
        webViewCollectionView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        webViewCollectionView.delegate = self
        webViewCollectionView.dataSource = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.keyboardType = .URL
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self

        for webView in webViews{
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
        
        plusBtn()
        constraints()
    }
    func constraints(){
        view.addSubview(webViewCollectionView)
        view.addSubview(selectorCollectionView)
        
        webViewCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        webViewCollectionView.bottomAnchor.constraint(equalTo: selectorCollectionView.topAnchor, constant: 0).isActive = true
        webViewCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webViewCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        selectorCollectionView.topAnchor.constraint(equalTo: webViewCollectionView.bottomAnchor, constant: 0).isActive = true
        selectorCollectionView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        selectorCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        selectorCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        selectorCollectionView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
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
            self.selectorCollectionView.reloadData()
            self.webViewCollectionView.reloadData()
            }
        }))

        self.present(alert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.identifier {
        case .top:
            return CGSize(width: 60, height: 60)
        case .bottom:
            return CGSize(width: UIScreen.main.bounds.width, height: webViewCollectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.identifier {
        case .top:
            return 2
        case .bottom:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.identifier {
        case .top:
            guard let cell = selectorCollectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as? TopCollectionViewCell else { return UICollectionViewCell()}
            
            cell.backgroundColor = UIColor.label.withAlphaComponent(0.7)
            cell.cornerRadius = 30
            cell.label.font = cell.label.font.withSize(20)
            cell.label.text = modelData[indexPath.item]
            let view = UIView(frame: cell.bounds)
            view.backgroundColor = .link
            view.cornerRadius = 30
            cell.selectedBackgroundView = view
            return cell
            
        case .bottom:
            guard let cell = webViewCollectionView.dequeueReusableCell(withReuseIdentifier: "bottomCollectionViewCell", for: indexPath) as? BottomCollectionViewCell else { return UICollectionViewCell() }

            cell.webView.removeFromSuperview()
                if indexPath.row+1 > webViews.count {

                    let webView = WKWebView(frame: cell.contentView.bounds)
                    webViews.append(webView)
                        
                    let url = URL(string: self.searchText ?? "https://enhance-quick-links.carrd.co/")
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.identifier {
        case .top:
            print(indexPath.item)
            self.webViewCollectionView.scrollToItem(at:indexPath, at: .centeredHorizontally, animated: true)
        case .bottom:
            print()
        }
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
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
            if keyPath == "estimatedProgress" {
                for webView in webViews{
                    self.searchController.searchBar.text = webView.url?.absoluteString
                }
            }
        }
}

extension UICollectionView {
    
    enum Identifier {
        case top
        case bottom
    }
    
    static var _identifier = [UICollectionView: Identifier]()
    
    var identifier: Identifier {
        get {
            return UICollectionView._identifier[self] ?? .top
        }
        set {
            UICollectionView._identifier[self] = newValue
        }
    }
}
