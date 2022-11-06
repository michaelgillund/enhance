//
//  Testing.swift
//  Enhance
//
//  Created by Michael Gillund on 9/30/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Testing: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStock()

//        print("FINAL ID: ", self.finalId)
    }
    struct Stock: Encodable, Decodable{
        var name: String
        var id: String
        
        init(name: String, id: String){
            self.name = name
            self.id = id
        }
    }
    struct Colors: Encodable, Decodable{
        var name: String
        var id: String
        var sizes: [Sizes]
        
        init(name: String, id: String, sizes: [Sizes]){
            self.name = name
            self.id = id
            self.sizes = sizes
        }
    }
    struct Sizes: Encodable, Decodable{
        var name: String
        var id: String
        var stock: String
        
        init(name: String, id: String, stock: String){
            self.name = name
            self.id = id
            self.stock = stock
        }
    }
    var productArray: [Stock] = []
    var colorArray: [Colors] = []
    var sizeArray: [Sizes] = []
    
    var keywords: [String] = []
    
    var productId: String = ""
    var colorId: String = ""
    var sizeId: String = ""
    
    var stockLevel = "0"
    func getStock(){
        AF.request("https://www.supremenewyork.com/mobile_stock.json").response { response in
                    switch response.result{
                        case .success(let value):
                            
                            let json = JSON(value!)
//                            print(json)
                            
                            for items in json["products_and_categories"]["new"].arrayValue {
                                let products = Stock.init(name: items["name"].stringValue, id: items["id"].stringValue)
                                self.productArray.append(products)
                            }
                            print("SEARCHING FOR PRODUCT...")
                            
                            let filtered = self.productArray.filter({return $0.name.contains("King") && $0.name.contains("Varsity") && !$0.name.contains("")})
                            let itemId = filtered.first?.id
                            let itemName = filtered.first?.name
                            self.productId = itemId ?? ""
                            
                            print("FOUND ITEM:", itemName ?? "")

                            
                            AF.request("https://www.supremenewyork.com/shop/\(itemId ?? "").json").response { response in
                                switch response.result{
                                    case .success(let value):
                                        
                                        let json = JSON(value!)
                                        print(json)
                                        
                                        for colors in json["styles"].arrayValue{
                                            for size in colors["sizes"].arrayValue{
                                                let sizes = Sizes.init(name: size["name"].stringValue, id: size["id"].stringValue, stock: size["stock_level"].stringValue)
                                                self.sizeArray.append(sizes)
//                                                print(self.sizeArray)
                                            }
                                            let productColors = Colors.init(name: colors["name"].stringValue, id: colors["id"].stringValue, sizes: self.sizeArray)
                                            self.colorArray.append(productColors)
//                                            print(self.colorArray)
                                            
//                                            for size in colors["sizes"].arrayValue{
//                                                let sizes = Sizes.init(name: size["name"].stringValue, id: size["id"].stringValue, stock: size["stock_level"].stringValue)
//                                                self.sizeArray.append(sizes)
////                                                print(self.sizeArray)
//                                            }
                                        
                                        }
//                                        print("SEARCHING FOR COLOR...")
//
//                                        let filteredColor = self.colorArray.filter({return $0.name.contains("Purple")})
//                                        let colorIds = filteredColor.first?.id
//                                        let colorName = filteredColor.first?.name
//                                        self.colorId = colorIds ?? ""
//
//                                        print("FOUND COLOR:", colorName ?? "")
//                                        print("SEARCHING FOR SIZE...")
//
//                                        let filteredSize = self.sizeArray.filter({return $0.name.contains("Small")})
//                                        let sizeIds = filteredSize.first?.id
//                                        let sizeName = filteredSize.first?.name
//                                        let sizeStock = filteredSize.first?.stock
//                                        self.sizeId = sizeIds ?? ""
//                                        print(filteredSize)
//
//                                        print("FOUND SIZE:", sizeName ?? "")
//                                        print(sizeStock ?? "")
//                                        if sizeStock == "1"{
//                                            print("IN-STOCK:", itemName ?? "")
//                                        }else{
//                                            print("OUT-OF-STOCK:", itemName ?? "")
//                                        }
//
//                                        print("PRODUCT ID: ", self.productId)
//                                        print("COLOR ID: ", self.colorId)
//                                        print("SIZE ID: ", self.sizeId)
                                        
//                                        print("ADDING TO CART...")
//                                        print("PRODUCT ADDED TO CART")
                                        
//                                        let colors = json["styles"].arrayValue
//                                        colors.forEach { color in
//                                            let colorId = color["id"].stringValue
//                                            print("COLOR ID: ", colorId)
//                                            print("START----------")
//                                            let colorName = color["name"].stringValue
//                                            print("COLOR:", colorName)
//                                            let imageUrl = color["bigger_zoomed_url"].stringValue
//                                            print("IMAGE:", imageUrl)
//                                            let sizes = color["sizes"].arrayValue
//                                            sizes.forEach { size in
//                                                let stockLevel = size["stock_level"].stringValue
//                                                let productSize = size["name"].stringValue
//                                                let sizeId = size["id"].stringValue
//                                                print("SIZE: ", productSize)
//                                                print("ID: ", sizeId)
//                                                print("STOCK LEVEL:", stockLevel)
//
//                                                if stockLevel == "1"{
//                                                    print("")
//                                                    print("IN STOCK")
//                                                    print("")
//                                                }
//                                                else if (stockLevel == "0") {
//                                                    print("")
//                                                    print("OUT OF STOCK")
//                                                    print("")
//                                                }
//                                                print("---------------")
//                                            }
//                                            print("END------------")
//                                            print("")
//                                        }
                                    case .failure(let error):
                                    print(error)
                                }
                            }
                        case .failure(let error):
                        print(error)
                    }
                }
            
        
    }
    
}

