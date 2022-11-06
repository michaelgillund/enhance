//
//  DiscordChannelList.swift
//  Enhance
//
//  Created by Michael Gillund on 5/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import Alamofire

class DiscordChannelListVC: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var arrChannelsList:[channelListObjects] = Array()
    var strServerID: String = ""
    var activityView: UIActivityIndicatorView?
    let xButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraints()
        xBtn()
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Monitors"
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        getAllChannelsList()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func constraints(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
    }
    func xBtn(){
        let xImage = UIImage(systemName: "xmark")?.applyingSymbolConfiguration(.init(pointSize: 13, weight: .heavy))
        xButton.setImage(xImage, for: .normal)
        
        let barItem = UIBarButtonItem(customView: xButton)
        navigationItem.rightBarButtonItem = barItem
        
        xButton.addTarget(self, action: #selector(xAction(_:)), for: .touchUpInside)
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.backgroundColor = UIColor.label.withAlphaComponent(0.7)
        xButton.layer.cornerRadius = 17.5
        xButton.tintColor = UIColor.systemBackground.withAlphaComponent(0.7)

        NSLayoutConstraint.activate([
            xButton.widthAnchor.constraint(equalToConstant: 35),
            xButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    @objc func xAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
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
    
    func getAllChannelsList()
    {
        if Connectivity.isConnectedToInternet
        {
            print("Yes! internet is available.")
               
            self.showActivityIndicator()
            
            let headers: HTTPHeaders = ["Authorization": GlobalParams.authorizationKey]
                        
            let apiUrl: String = "https://discordapp.com/api/guilds/699001155434446925/channels"
            
            print(apiUrl)
            
            AF.request(apiUrl,method:.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

                   // print(" Response channel list is...........", response)

                    switch response.result
                    {
                        case .success(let JSON):

                        self.hideActivityIndicator()
                            
                        let responseArray = JSON as! Array<Any>

                        if responseArray.count > 0
                        {
                            self.arrChannelsList = Array()
                            
                            for i in responseArray
                            {
                                let datadic = i as! [String : Any]
                                
                                var parentID : String = ""
                                
                                if (datadic["parent_id"] as? NSNull) != nil
                                {
                                   // print("null parent_id")
                                }
                                else
                                {
                                    parentID = datadic["parent_id"] as! String
                                }
                                
                                self.arrChannelsList.append(channelListObjects.init(id: datadic["id"] as! String, type: datadic["type"] as! NSNumber, name: datadic["name"] as! String, position: datadic["position"] as! NSNumber, parent_id: parentID, guild_id: datadic["guild_id"] as! String))
//                                print(self.arrChannelsList)
                                
                             }
                                                   
                            if self.arrChannelsList.count > 0
                            {
                                self.arrChannelsList.removeFirst(53)
                                self.arrChannelsList.removeLast(10)
                                self.arrChannelsList.remove(at: 23)
                                self.tableView.reloadData()
                            }
                        }

                        case .failure(let error):
                            
                        self.hideActivityIndicator()
                        print("Request failed with error: \(error)")
                    }
            }
        }
        else
        {
            print("No!!!! internet not available.")
        }
    }
    let dcvc = DiscordChatVC()
}

extension DiscordChannelListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChannelsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.selectionStyle = .none
        cell.visualEffectView.layer.cornerRadius = 10
        cell.visualEffectView.clipsToBounds = true
        
        let title = arrChannelsList[indexPath.row].name

        cell.titleLabel.text = "#" + title
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DiscordChatVC()
        vc.strChannelID = arrChannelsList[indexPath.row].id
//        let title = arrChannelsList[indexPath.row].name
//        vc.navigationItem.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


