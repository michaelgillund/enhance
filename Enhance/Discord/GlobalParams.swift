//
//  DiscordServerList.swift
//  Enhance
//
//  Created by Michael Gillund on 5/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


public class GlobalParams
{
    static let tokenNo = "699001155434446925";
    static let authorizationKey = "Bot NzEyMDM5MzA3MDc4MDA4ODQy.XsLwlQ.r44gPZcnIEoND1edKl9h-uZp39Y";
}
//public class GlobalParams
//{
//    static let tokenNo = "720483181371064359";
//    static let authorizationKey = "Bot NzIwNDgyNjM3MDE3NTEzOTg0.XuGnww.6sk-sb6Ljmd_7N2FJL37V04rt1M";
//}
//
//class DiscordServerListVC: UIViewController {
//
//    @IBOutlet weak var tblList: UITableView!
//    
//    var arrServerList:[serverListObjects] = Array()
//    
//    var activityView: UIActivityIndicatorView?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tblList.tableFooterView = UIView(frame: .zero)
//        
//        tblList.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
//        
//        getAllServerList()
//    }
//    
//    func showActivityIndicator() {
//        activityView = UIActivityIndicatorView(style: .large)
//        activityView?.center = self.view.center
//        self.view.addSubview(activityView!)
//        activityView?.startAnimating()
//    }
//
//    func hideActivityIndicator() {
//        if (activityView != nil){
//            activityView?.stopAnimating()
//        }
//    }
//    
//    func getAllServerList()
//    {
//        if Connectivity.isConnectedToInternet
//        {
//            print("Yes! internet is available.")
//               
//            self.showActivityIndicator()
//            
//            let headers: HTTPHeaders = ["Authorization": GlobalParams.authorizationKey]
//            
//            let apiUrl: String = "https://discordapp.com/api/users/@me/guilds"
//            
//            print(apiUrl)
//            
//            AF.request(apiUrl,method:.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//
//                    // print(" Response server list is...........", response)
//
//                    switch response.result
//                    {
//                        case .success(let JSON):
//
//                        self.hideActivityIndicator()
//                            
//                        let responseArray = JSON as! Array<Any>
//
//                        if responseArray.count > 0
//                        {
//                            self.arrServerList = Array()
//                            
//                            for i in responseArray
//                            {
//                                let datadic = i as! [String : Any]
//                                
//                                self.arrServerList.append(serverListObjects.init(id: datadic["id"] as! String, name: datadic["name"] as! String))
//                            }
//                            
//                            if self.arrServerList.count > 0
//                            {
//                                self.tblList.reloadData()
//                            }
//                        }
//                        
//                        case .failure(let error):
//                            
//                        self.hideActivityIndicator()
//                        print("Request failed with error: \(error)")
//                    }
//            }
//        }
//        else
//        {
//            print("No!!!! internet not available.")
//        }
//    }
//}
//
//extension DiscordServerListVC : UITableViewDelegate, UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return arrServerList.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 50
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell : ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
//        cell.selectionStyle = .none
//        
////        cell.viewContainer.layer.cornerRadius = 6
//        
//        let title = arrServerList[indexPath.row].name
//        
//        cell.titleLabel.text = title
//                
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        let vc : DiscordChannelListVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscordChannelListVC") as! DiscordChannelListVC
//        vc.strServerID = arrServerList[indexPath.row].id
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//
