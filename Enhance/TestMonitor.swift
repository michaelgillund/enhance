//
//  TestMonitor.swift
//  Enhance
//
//  Created by Michael Gillund on 9/17/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//


import Foundation
import UIKit
import WebKit
import Alamofire
import ActiveLabel
import UserNotifications

class testing: UIViewController, WKNavigationDelegate {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .label
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    var arrMsgList:[MsgListObjects] = Array()
    var strChannelID: String = ""
    var isFirstTimeCallTimer : Bool = true
    var isGoingForward : Bool = false
    var activityView: UIActivityIndicatorView?
    var timer = Timer()

    override func viewDidLoad(){
        super.viewDidLoad()
        constraints()
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Feed"

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.refreshControl = refresher
        
        getAllMessages(isFirstTimeExecute: true)
        print(arrMsgList)
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isGoingForward == true{
            isGoingForward = false
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.callApiEverySecond), userInfo: nil, repeats: true)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        stopRunningTimer()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func constraints() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        let deadline = DispatchTime.now() + .milliseconds(10)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            self.refresher.endRefreshing()
        }
    }
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator() {
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    func getAllMessages( isFirstTimeExecute : Bool ){
        if Connectivity.isConnectedToInternet {
            print("CONNECTED")
               
            if( isFirstTimeExecute ) {
                self.showActivityIndicator()
            }
            let headers: HTTPHeaders = ["Authorization": GlobalParams.authorizationKey]
            let apiUrl: String = "https://discordapp.com/api/channels/\(strChannelID)/messages"
            print("API URL:", apiUrl)
            AF.request(apiUrl,method:.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    switch response.result {
                        case .success(let JSON):
//                         print("Success with JSON: \(JSON)")
                         if let responseDict = JSON as? NSDictionary{
                            
                            let Code : NSNumber = responseDict.value(forKey: "code")! as! NSNumber
                            if Code == 10003{
                                let alertView = UIAlertController(title: "Oops!!!", message: responseDict.value(forKey: "message")! as? String, preferredStyle: .alert)

                                let alertAction = UIAlertAction(title: "Ok", style: .cancel) { (alert) in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alertView.addAction(alertAction)
                                self.present(alertView, animated: true, completion: nil)
                            }
                            self.stopRunningTimer()
                            return
                         }
                        if( isFirstTimeExecute ) {
                            self.hideActivityIndicator()
                        }
                            
                        let responseArray = JSON as! Array<Any>

                        if responseArray.count > 0 {
                            self.arrMsgList = Array()
                            
                            for i in responseArray {
                                
                                let datadic = i as! [String : Any]
                                let dictAuthor = datadic["author"]! as! NSDictionary
                                var arrayAuthor:[authorSub] = Array()
                                arrayAuthor.append(authorSub.init(id: dictAuthor["id"] as! String, userName: dictAuthor["username"] as! String))

//                                var arrayEmbed:[embedSub] = Array()
                                
//                                if let embeded = datadic["embeds"] as? [[String:Any]] {
//                                    for embed in embeded {
//                                        arrayEmbed.append(embedSub.init(title: embed["title"] as! String))
//                                    }
//                                }
//
//                                if let embeded = datadic["embeds"] as? [[String:Any]] {
//                                    for embed in embeded {
//                                        let title = embed["title"] as! String
//                                        print("Title", title)
//
//                                        let url = embed["url"] as! String
//                                        print("URL", url)
//
//                                        let fields = embed["fields"] as? [[String:Any]]
//                                        print("Fields", fields!)
//
//                                        let value = fields![2]
//                                        print("Value", value)
//
//                                    }
//                                }
                                let contentMsg = datadic["content"] as! String
                                self.arrMsgList.append(MsgListObjects.init(id: datadic["id"] as! String, type: datadic["type"] as! NSNumber, contentTextMsg: contentMsg , channelID: datadic["channel_id"] as! String, timeStamp: datadic["timestamp"] as! String, author: arrayAuthor))
                                print("ARRAY: \(self.arrMsgList)")
                                
//                                let n = self.arrMsgList.first
//                                //get the notification center
//                                let center =  UNUserNotificationCenter.current()
//
//                                //create the content for the notification
//                                let content = UNMutableNotificationContent()
//                                content.title = "Restock"
//                                content.body = "\(self.arrMsgList.first)"
//                                print("CONTENT \(contentMsg)")
//
//                                //notification trigger can be based on time, calendar or location
//                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
//
//                                //create request to display
//                                let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
//
//                                //add request to notification center
//                                center.add(request) { (error) in
//                                    if error != nil {
//                                        print("error \(String(describing: error))")
//                                    }
//                                }
//                                self.arrMonitorList.append(MontiorObjects.init(embed: arrayEmbed))
                            }
//                            print("MONITOR", self.arrMonitorList)
//                            print(". . . . . ", self.arrMsgList)
                       
                            if self.arrMsgList.count > 0 {
                                self.tableView.reloadData()
                                // self.scrollToBottom()
                            }
                            if ( self.isFirstTimeCallTimer ) {
                                self.isFirstTimeCallTimer = false
                                
                                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.callApiEverySecond), userInfo: nil, repeats: true)
                            }
                        }
                        case .failure(let error):
                            
                        if( isFirstTimeExecute ) {
                            self.hideActivityIndicator()
                        }
                        print("REQUEST FAILED: \(error)")
                    }
            }
        }
        else
        {
            print("NOT CONNECTED")
        }
    }
    
    @objc func callApiEverySecond() {
        self.getAllMessages(isFirstTimeExecute: false)
    }
    func stopRunningTimer() {
        if timer.isValid{
            timer.invalidate()
        }
    }
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrMsgList.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension testing : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMsgList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : MessageCell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.selectionStyle = .none
        let msg = arrMsgList[indexPath.row].contentTextMsg
        print("MESSAGE: \(msg)")

        cell.lblMsg.handleURLTap { (URL) in
            print("TAPPED:", URL)
            let vc = WebViewVC()
            let urlString: String = URL.absoluteString
            vc.urlPath = urlString
            self.navigationController?.pushViewController(vc, animated: true)
        }

        cell.lblMsg.text = msg
        cell.lblMsg.sizeToFit()
        cell.lblMsg.tag = indexPath.row
        cell.lblSenderName.text = "By : \(arrMsgList[indexPath.row].author[0].userName)"
        
        let date =  arrMsgList[indexPath.row].timeStamp // "2020-05-12T11:10:04.910000+00:00" //
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(identifier: "CEST +5:30")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
         // NSTimeZone(name: "UTC")! as TimeZone
        let newDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        let dateTimeString = dateFormatter.string(from: newDate!)

        cell.lblDateTime.text = dateTimeString
                
        return cell
    }

    
    @objc func labelClicked(_ sender: UIGestureRecognizer) {
        let tappedText = sender.view as! UILabel
        print(tappedText.text!)

        if tappedText.text!.validateUrl() == true
        {
            isGoingForward = true

            let vc : WebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            vc.urlPath = tappedText.text!
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
}


