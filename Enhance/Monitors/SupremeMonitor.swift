//
//  SupremeMonitor.swift
//  Enhance
//
//  Created by Michael Gillund on 9/17/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit
import SwiftyJSON

class SupremeMonitor: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "New Products"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .label
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    let keywords = ["Collage","Logo"]
    let category = "new"
    let blurEffect = UIBlurEffect(style: .systemMaterialDark)
    var blurEffectView = UIVisualEffectView()
    
    var newArray: [New] = Array()
    var stockArray: [Style] = Array()
    var imageArray: [HDImages] = Array()
    var timer = Timer()
    var timerAPI = Timer()
    var ticker = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        
        constraints()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SupremeMonitorCell.self, forCellReuseIdentifier: "SupremeMonitorCell")
        self.tableView.separatorColor = .clear
        self.tableView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//        tableView.refreshControl = refresher
        
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(ReleaseController.DateandTime), userInfo: nil, repeats: true)

        self.navigationItem.title = "Monitor"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(refresh))
        navBar()
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.alpha = 0.0
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(blurEffectView)
//
//        blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        blurEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        


        
//        let statWindow = UIApplication.shared.value(forKey:"statusBarWindow") as! UIView
//        let statusBar = statWindow.subviews[0] as UIView
//        statusBar.backgroundColor = UIColor.clear
//        let blur = UIBlurEffect(style:.dark)
//        let visualeffect = UIVisualEffectView(effect: blur)
//        visualeffect.frame = statusBar.frame
//        //statusBar.addSubview(visualeffect)
//        visualeffect.alpha = 0.5
//        self.view.addSubview(visualeffect)
        
        getProducts()
//        timerAPI = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(getProducts), userInfo: nil, repeats: true)
//        getStock()
        print("VIEW DIDLOAD:",self.newArray)

    }
    func navBar(){
        let navigationView = UIView()
        self.navigationItem.titleView = navigationView
        if let navigationBar = self.navigationController?.navigationBar {
           navigationBar.addSubview(timeLabel)
            timeLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0).isActive = true
            timeLabel.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16).isActive = true // set the constant how do you prefer
            timeLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16).isActive = true
            timeLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -20).isActive = true
            timeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    @objc func DateandTime(){
        let template = "EEEEdMMMM"

        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: NSLocale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format

        let now = Date()
        let date = formatter.string(from: now)
        
        timeLabel.text = date.uppercased()
    }
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
//        let deadline = DispatchTime.now() + .milliseconds(5)
//        DispatchQueue.main.asyncAfter(deadline: deadline){
//            self.refresher.endRefreshing()
//        }
    }

    func constraints() {
//        view.addSubview(timeLabel)
//        view.addSubview(label)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
//        timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
//        timeLabel.bottomAnchor.constraint(equalTo: label.topAnchor, constant: 0).isActive = true
//        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//
//        label.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = true
//        label.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
//        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

//        tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    func getStock(){
        let url = URL(string: "https://www.supremenewyork.com/shop/173582.json")!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                print("ERROR:", error)
            
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Stock.self, from: data)
                    self.stockArray = response.styles
//                    print(self.stockArray)
                    } catch {
                        print(error)
                    }
                } else {
                    print("UNEXPECTED ERROR")
            }
        }.resume()
//        let stockLevels = Size.CodingKeys.stockLevel
//        print(stockLevels)
//        if stockLevels == "1" && self.ticker == "1"{
//            print("IN STOCK")
//            print("")
//            self.ticker = "0"
//        }else if (stockLevels.rawValue == "0") {
//            print("OUT OF STOCK")
//            print("")
//            self.ticker = "1"
//            }
    }
    @objc func getProducts(){
        let url = URL(string: "https://www.supremenewyork.com/mobile_stock.json")!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data{
                let x = JSON(data)
//                print("DATA",x)
                do {
                    let response = try JSONDecoder().decode(Products.self, from: data)
                    let new = response.products.new
                    self.newArray = response.products.new
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
//                    print(self.newArray)
//                    self.newArray.append(contentsOf: new)
                    
                    let z = self.newArray.filter({return $0.name == "\(self.keywords)"})
                    print("FILTERED: ", z)


//                    let filtered : [String] = self.newArray.filter({ (keyword1) in
//
//                    let foundKeyword = self.keywords.filter({(keyword2) in
//                        return keyword1.contains(keyword2)
//                        })
//
//                    return foundKeyword.count == self.keywords.count
//                    })
//                    print(filtered)
                } catch {
                    print(error)
                }
                
            }
        
        }.resume()
//        print("AFTER JSON:", self.newArray)
//        print("API CALLED")
    }
    func statusBlur(){
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 1.0
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
                
        blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurEffectView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        blurEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if scrollView.contentSize.height > 0 && ((scrollView.contentOffset.y + scrollView.safeAreaInsets.top) == 0) {
//            timeLabel.alpha = 0
//            navigationItem.title = ""
//        }
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if tableView.contentOffset.y <= 0 {
//            navigationItem.title = "Monitor"
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
//                self.timeLabel.alpha = 1
//            } completion: { (_) in
//                print("visible TimeLabel")
//            }
//        }
//    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        blurEffectView.alpha = 1

//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        blurEffectView.alpha = 0
//        print("END DECELERATING")
//
//    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        blurEffectView.alpha = 0
//        print("END DRAGGING")
//    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        statusBlur()
//        print("BEGIN DRAGGING")
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SupremeMonitorCell = tableView.dequeueReusableCell(withIdentifier: "SupremeMonitorCell", for: indexPath) as! SupremeMonitorCell
        cell.backgroundColor = .clear

        let products = newArray[indexPath.row]
        let name = products.name
        let id = products.id
//        print("ID:", id)
        
//        let url = URL(string: "https://www.supremenewyork.com/shop/\(id).json")!
//        let request = URLRequest(url: url)
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                print("ERROR:", error)
//
//            } else if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(Images.self, from: data)
//                    self.imageArray = response.styles
////                    print(self.imageArray)
//                    } catch {
//                        print(error)
//                    }
//                } else {
//                    print("UNEXPECTED ERROR")
//            }
//        }.resume()
//        let stock = imageArray[indexPath.row]
//        let x = stock.biggerZoomedURL
//        print(x)
        let category = products.category
        var price = String(products.price)
        price.insert(".", at: price.index(price.endIndex, offsetBy: -2))

        let image = products.image
        let urls = URL(string: "https:\(image)")

        cell.nameLabel.text = name
        cell.categoryLabel.text = "Category: " + category
        cell.priceLabel.text = "Price: $" + price
        cell.productImage.load(url: urls!)
        
        cell.selectionStyle = .none
        return cell
    }
    func setTitle(subtitle:UILabel) -> UIView {
        
        let navigationBarHeight = Int(self.navigationController!.navigationBar.frame.height)
        let navigationBarWidth = Int(self.navigationController!.navigationBar.frame.width)

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: navigationBarWidth, height: navigationBarHeight))
        titleView.addSubview(subtitle)

        return titleView

    }
    var poop = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InStock()
        let products = newArray[indexPath.row]
        let id = products.id
        
        
        
        let url = URL(string: "https://www.supremenewyork.com/shop/\(id).json")!
        print(url)
                let request = URLRequest(url: url)
                let session = URLSession.shared
                let task = session.dataTask(with: request) { (data, response, error) in

                    if let error = error {
                        print("ERROR:", error)
                    
                    } else if let data = data {
//                        do {
//                            let response = try JSONDecoder().decode(Stock.self, from: data)
//                            self.stockArray = response.styles
//                            print(self.stockArray)
//
//                        } catch {
//                            print(error)
//                        }
                        let json = JSON(data)
                        print(json)
                        let colors = json["styles"].arrayValue
                        colors.forEach { color in
                            print("---------------")
                            let colorName = color["name"].stringValue
                            print("COLOR:", colorName)
                            let imageUrl = color["bigger_zoomed_url"].stringValue
                            print("IMAGE:", imageUrl)
                            let sizes = color["sizes"].arrayValue
                            sizes.forEach { size in
                                let stockLevel = size["stock_level"].stringValue
                                let sizeName = size["name"].stringValue
                                print("STOCK LEVEL: \(sizeName)", stockLevel)
                                print("---------------")
                                if stockLevel == "1" && self.ticker == "1"{
                                    print("IN STOCK")
                                    print("")
                                    self.ticker = "0"
                                }
                                else if (stockLevel == "0") {
                                    print("OUT OF STOCK")
                                    print("")
                                    self.ticker = "1"
                                    }
                                }
                            }
                        } else {
                        print("UNEXPECTED ERROR")
                    }
                }
                task.resume()
//        let url = URL(string: "https://www.supremenewyork.com/shop/\(id).json")!
//        let request = URLRequest(url: url)
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            let x = JSON(data)
////            print(x)
//            if let error = error {
//                print("ERROR:", error)
//
//            } else if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(Stock.self, from: data)
//                    self.stockArray = response.styles
//                    print(self.stockArray)
//
//                    let array = self.stockArray[0]
//                    print("STOCK LEVEL",array.sizes[0].stockLevel)
//                    vc.stockLabel = self.stockArray[0].sizes[0].stockLevel
//                    } catch {
//                        print(error)
//                    }
//                } else {
//                    print("UNEXPECTED ERROR")
//            }
//        }.resume()
        let name = products.name
        let x = products.category
        var price = String(products.price)
        price.insert(".", at: price.index(price.endIndex, offsetBy: -2))
//        vc.itemName = name
//        present(vc, animated: true, completion: nil)
        
        //Notification Content
        let content = UNMutableNotificationContent()
        content.title = "\(name)"
        content.subtitle = "Category: \(x)"
        content.body = "$\(price)"
//                                content.categoryIdentifier = "INVITATION"
        content.sound = UNNotificationSound.default
                
                //Notification Trigger - when the notification should be fired
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                
                //Notification Request
        let requestq = UNNotificationRequest(identifier: "poop", content: content, trigger: trigger)
                
                //Scheduling the Notification
        let center = UNUserNotificationCenter.current()
            center.add(requestq) { (error) in
                if let error = error
                {
                    print(error.localizedDescription)
                }
            }
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}
