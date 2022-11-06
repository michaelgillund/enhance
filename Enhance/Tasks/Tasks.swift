//
//  Tasks.swift
//  Enhance
//
//  Created by Michael Gillund on 10/10/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class Tasks: UIViewController {

    private let logo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Logo.png")
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        
        self.navigationItem.title = "Tasks"
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 250),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        logo.rotate360Degrees()
        // Do any additional setup after loading the view.
        let welcome = BaulettoSettings(icon: UIImage(named: "LogoSmall"), title: "Welcome", tintColor: .white, backgroundStyle: .dark, dismissMode: .custom(seconds: 0.5))
        Bauletto.show(withSettings: welcome)
//        request()
    }
    struct Stock: Encodable, Decodable{
        var name: String
        var id: String
        
        init(name: String, id: String){
            self.name = name
            
            self.id = id
        }
    }
    struct Colors: Codable {
        let styles: [Style]
    }

    // MARK: - Style
    struct Style: Codable {
        let name: String
        let sizes: [Size]
    }

    // MARK: - Size
    struct Size: Codable {
        let stockLevel, id: Int
        let name: String

        enum CodingKeys: String, CodingKey {
            case stockLevel = "stock_level"
            case id, name
        }
    }
    var productArray: [Stock] = []
    var colorsArray: [Colors] = []
    @objc func request(){
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
                            
                            print("FOUND ITEM:", itemName ?? "")

                            
                            AF.request("https://www.supremenewyork.com/shop/\(itemId ?? "").json").response { response in
                                switch response.result{
                                    case .success(let value):
                                        
                                        let json = JSON(value!)
//                                        print(json)
                                        let colors = try? self.newJSONDecoder().decode(Colors.self, from: value!)
//                                        print(colors!)
                                        self.colorsArray.append(colors!)
                                        print(self.colorsArray)

//                                        print("SEARCHING FOR COLOR...")
//
//                                        let filteredColor = self.colorsArray.filter({return $0.name.contains("Purple")})
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

                                    case .failure(let error):
                                    print(error)
                                }
                            }
                        case .failure(let error):
                        print(error)
                    }
                }
            
        
    }

    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
}
