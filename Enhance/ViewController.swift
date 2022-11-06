//
//  ViewController.swift
//  Enhance
//
//  Created by Michael Gillund on 3/31/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import Firebase

struct Fonts {
    static let SQMedium15 = UIFont(name: "SQMarket-Medium", size: 15)
    static let SQMedium20 = UIFont(name: "SQMarket-Medium", size: 20)
    static let SQMedium25 = UIFont(name: "SQMarket-Medium", size: 25)
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let supremeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.93, green: 0.00, blue: 0.00, alpha: 1.00)
        button.cornerRadius = 10
        let image = UIImage(named: "Supreme.png")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let yeezyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        button.cornerRadius = 10
        let image = UIImage(named: "Yeezy.png")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let shopifyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.03, green: 0.85, blue: 0.25, alpha: 1.00)
        button.cornerRadius = 10
        let image = UIImage(named: "Shopify.png")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let twitterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.00, green: 0.60, blue: 1.20, alpha: 1.00)
        button.cornerRadius = 10
        let image = UIImage(named: "Twitter.png")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(DashboardCell.self, forCellWithReuseIdentifier: "DashboardCell")
//        collection.isPagingEnabled = true
        collection.backgroundColor = UIColor.clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var db: Firestore!
    var panel: FloatingPanelController!
    var releaseController: ReleaseController!
    let settingsButton = UIButton(type: .system)
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ssZZZ"
        let lastLogin = UserDefaults.standard.string(forKey: "lastLogin")
        if (lastLogin != nil && Date() < dateFormatter.date(from: lastLogin!)!.addingTimeInterval(864000)) { } else { login() }
        collection()
//        constraints()
//        settingsBtn()
//        setupPanel()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.title = "Dashboard"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Bold", size: 36) ?? UIFont.systemFont(ofSize: 36)]
    
        supremeButton.shadowBtn()
        yeezyButton.shadowBtn()
        shopifyButton.shadowBtn()
        twitterButton.shadowBtn()

    }
    func collection(){
//        let flowLayout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
//
//        collectionView.register(DashboardCell.self, forCellWithReuseIdentifier: "DashboardCell")
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = UIColor.clear

//        view.addSubview(mainView)
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
//        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34).isActive = true
//        mainView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        panel.addPanel(toParent: self, animated: true)
        gradients()
    }
    func login(){
        let login = Login()
        login.modalPresentationStyle = .fullScreen
        login.modalTransitionStyle = .crossDissolve
        present(login, animated: false, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 125)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("item at \(indexPath.section)/\(indexPath.item) tapped")
        if indexPath.section == 0 && indexPath.item == 0 {
            let supreme = Supreme()
            self.navigationController?.pushViewController(supreme, animated: true)
        }
        if indexPath.section == 0 && indexPath.item == 1 {
            let yeezy = Yeezy()
            self.navigationController?.pushViewController(yeezy, animated: true)
        }
        if indexPath.section == 0 && indexPath.item == 2 {
            let shopify = UINavigationController(rootViewController: ShopifyWebView())
            present(shopify, animated: true, completion: nil)
        }
        if indexPath.section == 0 && indexPath.item == 3 {
            let twitter = UINavigationController(rootViewController: TwitterWebView())
            present(twitter, animated: true, completion: nil)
        }
      }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as! DashboardCell

        if indexPath.section == 0 && indexPath.item == 0 {
            cell.contentView.applyGradient(colors: [UIColor(red: 0.93, green: 0.00, blue: 0.00, alpha: 1.00).cgColor,
                                                    UIColor.red.cgColor])
            let image = UIImage(named: "Supreme.png")
            cell.imageView.image = image
        }
        if indexPath.section == 0 && indexPath.item == 1 {
            cell.contentView.applyGradient(colors: [UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.00).cgColor,
                                                    UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.00).cgColor])
            let image = UIImage(named: "Yeezy.png")
            cell.imageView.image = image

        }
        if indexPath.section == 0 && indexPath.item == 2 {
            cell.contentView.applyGradient(colors: [UIColor(red: 0.03, green: 0.85, blue: 0.25, alpha: 1.00).cgColor,
                                                    UIColor(red: 0.21, green: 0.80, blue: 0.31, alpha: 1.00).cgColor])
            let image = UIImage(named: "Shopify.png")
            cell.imageView.image = image
        }
        if indexPath.section == 0 && indexPath.item == 3 {
            cell.contentView.applyGradient(colors: [UIColor(red: 0.00, green: 0.45, blue: 1.20, alpha: 1.00).cgColor,
                                                    UIColor(red: 0.00, green: 0.60, blue: 1.20, alpha: 1.00).cgColor])
            let image = UIImage(named: "Twitter.png")
            cell.imageView.image = image
        }
        return cell
    }
    func gradients(){
        supremeButton.applyGradient(colors: [UIColor(red: 0.93, green: 0.00, blue: 0.00, alpha: 1.00).cgColor, UIColor.red.cgColor])
        yeezyButton.applyGradient(colors: [UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00).cgColor, UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1.00).cgColor])
        shopifyButton.applyGradient(colors: [UIColor(red: 0.03, green: 0.85, blue: 0.25, alpha: 1.00).cgColor, UIColor(red: 0.21, green: 0.80, blue: 0.31, alpha: 1.00).cgColor])
        twitterButton.applyGradient(colors: [UIColor(red: 0.00, green: 0.45, blue: 1.20, alpha: 1.00).cgColor, UIColor(red: 0.00, green: 0.60, blue: 1.20, alpha: 1.00).cgColor])
    }
    func constraints(){

        view.addSubview(supremeButton)
        view.addSubview(yeezyButton)
        view.addSubview(shopifyButton)
        view.addSubview(twitterButton)


        supremeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        supremeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        supremeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        supremeButton.bottomAnchor.constraint(equalTo: yeezyButton.topAnchor, constant: -8).isActive = true
        supremeButton.heightAnchor.constraint(equalToConstant: 85).isActive = true

        yeezyButton.topAnchor.constraint(equalTo: supremeButton.bottomAnchor, constant: 0).isActive = true
        yeezyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        yeezyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        yeezyButton.bottomAnchor.constraint(equalTo: shopifyButton.topAnchor, constant: -8).isActive = true
        yeezyButton.heightAnchor.constraint(equalToConstant: 85).isActive = true

        shopifyButton.topAnchor.constraint(equalTo: yeezyButton.bottomAnchor, constant: 0).isActive = true
        shopifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        shopifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        shopifyButton.bottomAnchor.constraint(equalTo: twitterButton.topAnchor, constant: -8).isActive = true
        shopifyButton.heightAnchor.constraint(equalToConstant: 85).isActive = true

        twitterButton.topAnchor.constraint(equalTo: shopifyButton.bottomAnchor, constant: 8).isActive = true
        twitterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        twitterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 85).isActive = true

        supremeButton.addTarget(self, action: #selector(supreme), for: .touchUpInside)
        yeezyButton.addTarget(self, action: #selector(yeezy), for: .touchUpInside)
        shopifyButton.addTarget(self, action: #selector(shopify), for: .touchUpInside)
        twitterButton.addTarget(self, action: #selector(twitter), for: .touchUpInside)
    }


    func settingsBtn(){
        let xImage = UIImage(systemName: "gear")?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .heavy))
        settingsButton.setImage(xImage, for: .normal)
        
        let barItem = UIBarButtonItem(customView: settingsButton)
        navigationItem.rightBarButtonItem = barItem
        
        settingsButton.addTarget(self, action: #selector(settingsAction), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.backgroundColor = UIColor.label.withAlphaComponent(0.7)
        settingsButton.layer.cornerRadius = 20
        settingsButton.tintColor = UIColor.systemBackground.withAlphaComponent(0.7)

        NSLayoutConstraint.activate([
        settingsButton.widthAnchor.constraint(equalToConstant: 40),
        settingsButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    @objc func settingsAction(_ sender: Any) {
        let settingsViewController = Settings()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
        
    }
    // BUTTON ANIMATION
    @objc func supreme(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
        animations: {
        sender.transform = CGAffineTransform(scaleX: 0.96, y: 0.975)
        },
        completion: { finish in
        UIButton.animate(withDuration: 0.2, animations: {
        sender.transform = CGAffineTransform.identity
        })
        })
        let supreme = Supreme()
        self.navigationController?.pushViewController(supreme, animated: true)
    }
    @objc func shopify(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
        animations: {
        sender.transform = CGAffineTransform(scaleX: 0.96, y: 0.975)
        },
        completion: { finish in
        UIButton.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform.identity
            })
        })
        
        let shopifyViewController = UINavigationController(rootViewController: ShopifyWebView())
        present(shopifyViewController, animated: true, completion: nil)
        
    }
    @objc func yeezy(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
        animations: {
        sender.transform = CGAffineTransform(scaleX: 0.96, y: 0.975)
        },
        completion: { finish in
        UIButton.animate(withDuration: 0.2, animations: {
        sender.transform = CGAffineTransform.identity
        })
        })
        let yeezyViewController = Yeezy()
        self.navigationController?.pushViewController(yeezyViewController, animated: true)
      
    }
    @objc func twitter(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
        animations: {
        sender.transform = CGAffineTransform(scaleX: 0.96, y: 0.975)
        },
        completion: { finish in
        UIButton.animate(withDuration: 0.2, animations: {
        sender.transform = CGAffineTransform.identity
        })
        })
        
        let twitterViewController = UINavigationController(rootViewController: TwitterWebView())
        present(twitterViewController, animated: true, completion: nil)
    }
}
//extension ViewController: FloatingPanelControllerDelegate{
//
//    func setupPanel(){
//        panel = FloatingPanelController()
//        panel.delegate = self
//
//        // Initialize FloatingPanelController and add the view
//        panel.surfaceView.backgroundColor = .clear
//
//        if #available(iOS 11, *) {
//            panel.surfaceView.cornerRadius = 15.0
//        } else {
//            panel.surfaceView.cornerRadius = 0.0
//        }
//        panel.surfaceView.shadowHidden = false
//
//
//        releaseController = ReleaseController()
////        self.releaseController.tableView.alpha = 0.0
//
//        // Set a content view controller
//        panel.set(contentViewController: releaseController)
//        panel.track(scrollView: releaseController.tableView)
//    }
//    // MARK: FloatingPanelControllerDelegate
//
//    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
//        return ReleaseLayout()
//    }
//    func floatingPanelDidMove(_ vc: FloatingPanelController) {
//        let y = vc.surfaceView.frame.origin.y
//        let tipY = vc.originYOfSurface(for: .tip)
//        if y > tipY - 44.0 {
//            let progress = max(0.0, min((tipY  - y) / 44.0, 1.0))
//            self.releaseController.tableView.alpha = progress
//        }
//    }
//    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
//        if vc.position == .tip {
//
//        }
//    }
//    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
//        UIView.animate(withDuration: 0.25,
//                       delay: 0.0,
//                       options: .allowUserInteraction,
//                       animations: {
//                        if targetPosition == .tip {
//                            self.releaseController.tableView.alpha = 0.0
//                        } else {
//                            self.releaseController.tableView.alpha = 1.0
//                        }
//        }, completion: nil)
//    }
//}
//
