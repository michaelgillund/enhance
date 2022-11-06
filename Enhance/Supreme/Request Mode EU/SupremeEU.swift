//
//  SupremeEU.swift
//  Enhance
//
//  Created by Michael Gillund on 7/6/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import Foundation
import SwiftyJSON

let typeReq = UserDefaults.standard.string(forKey: "typeReq") ?? ""

class SupremeEU
{
    //Edit here
    let keyword1 = UserDefaults.standard.string(forKey: "keyword1ReqEU") ?? ""
    let category1 = UserDefaults.standard.string(forKey: "category1ReqEU") ?? ""
    let size1 = UserDefaults.standard.string(forKey: "size1ReqEU") ?? ""
    let color1 = UserDefaults.standard.string(forKey: "color1ReqEU") ?? ""

    
    //Item Info
    lazy var items: [String] = { ["\(self.keyword1)"] }()
    lazy var categories:[String] = { ["\(self.category1)"] }()
    lazy var sizes:[String] = { ["\(self.size1)"] }()
    lazy var colors:[String] = { ["\(self.color1)"] }()

    //User Info
    var uName = "\(fullNameReq)"
    var uEmail = "\(emailReq)"
    var uPhone = "\(phoneReq)"
    var uAddress = "\(addressReq)"
    var uAddress2 = "\(address2Req)"
    var uCity = "\(cityReq)"
    var uState = "IL"
    var uZip = "\(zipReq)"
    var uCCNum = "\(ccReq)"
    var uCCMonth = "\(monthReq)"
    var uCCYear = "\(yearReq)"
    var uCCCVV = "\(cvvReq)"

    var location = "\(countryReq)" //Use "US" or "EU"
    var atc:Bool = true
    var atcDelay = 2500 //ms
    
    var ccType = "\(typeReq)" // "Visa", "American Express", "Mastercard", "Solo"
    
    
    //DO NOT EDIT BELOW THIS LINE
    
    //Class Variables
    weak var supremeInstance: SupremeEU?
    var stepFunction: Int = 0
    var timer: DispatchSourceTimer?
    var timerItemStyle: DispatchSourceTimer?
    
    //Time the bot
    var timeToRun = Timer()
    var seconds = 0

    //Delay Variables
    var delayCheckoutClick = 250
    var finalDelay = 0
    
    //Item Variables
    var W2CColor = ""
    var W2CSize = ""
    var W2CName = ""
    var W2CCategory = ""
    var quantity = ""
    var loaded = false
    var currentCategory = ""
    var numItems = 0
    var currentItem = 0
    
    //IDs
    var idName = "order_billing_name"
    var idEmail = "order_email"
    var idPhone = "order_tel"
    var idAddress1 = "order_billing_address"
    var idAddress2 = "order_billing_address_2"
    var idAddress3 = "order_billing_address_3"
    var idZip = "order_billing_zip"
    var idCity = "order_billing_city"
    var idState = "order_billing_state"
    var idCountry = "order_billing_country"
    var idCCType = "credit_card_type" //not applicable for North America
    var idCC = "credit_card_n"
    var idCCM = "credit_card_month"
    var idCCY = "credit_card_year"
    var idCVV = "credit_card[ovv]"
    
    var addressPt2 = false

    //Link view controller
    var requestWebView: RequestWebViewEU?

    
    //Link viewController again
    init(withViewController viewController: RequestWebViewEU)
    {
        self.requestWebView = viewController
    }
    
    //INIT SUPREMEINSTANCE
    init(withSupremeInstance supremeInstance: SupremeEU)
    {
        self.supremeInstance = supremeInstance
    }

    
    func startTimer(){
        timeToRun = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        seconds += 1
    }
    
    //start Bot
    func startProcess()
    {
        //start timing
        startTimer()
        seconds = 0
        
        //reset variables
        numItems = 0
        currentItem = 0
        
        //get first item info from arrays
        W2CName = items[0].lowercased()
        W2CColor = colors[0].lowercased()
        W2CSize = sizes[0].lowercased()
        W2CCategory = categories[0].lowercased()
        
        //see how many items there are
        numItems = (items.count - 1)
        
        //tell viewController bot is starting
        self.requestWebView!.botRunning = true
        
        //setup javascript event
        DispatchQueue.main.async {
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("""
                let event = document.createEvent('Event');
                event.initEvent('change', true, true);
                """, completionHandler: nil)
            
        }
        
        
        print("Checking Out Product:",W2CName, "\t In Category:", W2CCategory)
        self.loadCategory()

    }
    
    //End bot
    func stopProcess()
    {
        //return time
        print("Completed")
        
        print("Checkout Time:", seconds, "Seconds")
        seconds = 0
        
        //reset timer
        self.timerItemStyle?.cancel()
        self.timerItemStyle = nil
        
        //tell viewController bot is done
        self.requestWebView!.botRunning = false
        
    }
        
    //load the selected category
    func loadCategory()
    {
        //for the first item, the url can be changed. Will cause problems (on Supreme's end) if this happens more than once.
        if currentItem == 0{
            
            //change to uppercase
            if W2CCategory == "new"{
                currentCategory = "New"
            }else if W2CCategory == "jackets"{
                currentCategory = "Jackets"
            }else if W2CCategory == "shirts"{
                currentCategory = "Shirts"
            }else if W2CCategory == "tops/sweaters"{
                currentCategory = "Tops/Sweaters"
            }else if W2CCategory == "sweatshirts"{
                currentCategory = "Sweatshirts"
            }else if W2CCategory == "pants"{
                currentCategory = "Pants"
            }else if W2CCategory == "shorts"{
                currentCategory = "Shorts"
            }else if W2CCategory == "t-shirts"{
                currentCategory = "T-Shirts"
            }else if W2CCategory == "hats"{
                currentCategory = "Hats"
            }else if W2CCategory == "bags"{
                currentCategory = "Bags"
            }else if W2CCategory == "accessories"{
                currentCategory = "Accessories"
            }else if W2CCategory == "skate"{
                currentCategory = "Skate"
            }else if W2CCategory == "shoes"{
                currentCategory = "Shoes"
            }

            
            DispatchQueue.main.async{
                //Make sure the category is on the page
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(self.W2CCategory)-category').innerHTML",
                                                                        completionHandler:
                    { (catText: Any?, error: Error?) in
                        //If this returns nil, category hasnt loaded
                        if catText == nil{
                            //refresh
                            self.requestWebView?.supremeBrowser?.evaluateJavaScript("location.reload(true)", completionHandler: nil)
                            //Wait 850-1000ms and try again
                            let browswerBackgroundWaitCategory = DispatchQueue(label: "browswerBackgroundWaitCategory", qos: .userInitiated)
                            let ranRefresh = Int.random(in: 850 ... 1000)
                            browswerBackgroundWaitCategory.asyncAfter(deadline: .now() + .milliseconds(ranRefresh)){
                                //another attempt
                                self.loadCategory()
                            }
                        }else{
                            //if loaded, navigate to the categorie's url
                            let categoryLink = "https://www.supremenewyork.com/mobile/#categories/" + self.currentCategory
                            print(categoryLink)
                            DispatchQueue.main.async{
                                self.requestWebView?.supremeBrowser?.evaluateJavaScript("window.location.href = '\(categoryLink)';", completionHandler: nil)
                                
                            }
                            //Start looking for items
                            self.loadItems()
                        }
                })
            }
        }else{
            //If this is not the first item, click the button for this category instead
            let selector = W2CCategory + "-category"

            let browserDelayQLoad = DispatchQueue(label: "browserDelayQLoad", qos: .userInitiated)
            browserDelayQLoad.asyncAfter(deadline: .now() + .milliseconds(125))
            {
                DispatchQueue.main.async{
                    self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(selector)').click()", completionHandler: nil)
                }
            }
            //Now start looking for items
            self.loadItems()
        }
    }
    
    func startNext(){
        //Called whenever an item is done to check if there is another
        print("Going Home")
        DispatchQueue.main.async {
            //This can be buggy sometimes, but this was the best method I found
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("window.history.go(-3);", completionHandler: nil)
        }

        //Get info for the next item
        if currentItem <  numItems{
            self.currentItem += 1
            W2CName = items[currentItem].lowercased()
            W2CColor = colors[currentItem].lowercased()
            W2CSize = sizes[currentItem]
            W2CCategory = categories[currentItem]
            //Make sure bot ready for next item
            self.canNext()
        }else{
            //If there is only one item, checkout
            self.checkoutButton()
        }
    }

    func canNext(){
        //Make sure ready to begin for any item after the first
        DispatchQueue.main.async{
            //Check the length of the url
            //The homepage has a length of 49 characters
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("window.location.href.length",
                                                                    completionHandler:
                { (classV: Any?, error: Error?) in
                    //If nil is returned, keep trying because navigation still in progress
                    if classV == nil{
                        self.canNext()
                    }else{
                        //If the length is < 50, then the bot is back on the homepage and the next item can begin
                        let hrefLen = classV as! Int
                        if hrefLen <= 50{
                            let ranDelayCategory = Int.random(in: 95 ... 126) //just being safe
                            let browserDelayQ1 = DispatchQueue(label: "browswerBackgroundQ1", qos: .userInitiated)
                            browserDelayQ1.asyncAfter(deadline: .now() + .milliseconds(ranDelayCategory))
                            {
                                //Load the category for the next item
                                self.loadCategory()
                            }
                        }else{
                            //If not on homepage, wait
                            self.canNext()
                        }
                    }
            })
        }
    }

    //make sure the category page has loaded
    func loadItems(){
        DispatchQueue.main.async {
            //Get the amount of items on the page
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementsByClassName('name').length",
                                                                completionHandler:
                { (length: Any?, error: Error?) in
                    if length == nil{
                        //hasnt loaded yet, try again
                        self.loadItems()
                    }else{
                        let itemLength = length as! Int
                        if itemLength > 0{
                            //category page loaded
                            self.findItem()
                        }else{
                            //hasnt loaded yet, try again
                            self.loadItems()
                        }
                    }
            })
        }
    }
        
    //scan every item name in HTML and look for matching keywords
    func findItem()
    {

        print("Searching...")
        
        let browserDelayQFind = DispatchQueue(label: "browserDelayQFind", qos: .userInitiated)
        browserDelayQFind.asyncAfter(deadline: .now() + .milliseconds(100))
        {
            DispatchQueue.main.async{
                if let i = self.W2CName.firstIndex(of: "+") {
                    self.W2CName.remove(at: i)
                }
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("""
                    var keyword = '\(self.W2CName)'
                    var items = document.getElementsByClassName("name");
                    for (item of items) {
                        var name = item.innerHTML.toLowerCase()
                        if (name.includes(keyword)){
                            var ans = "Found: " + name
                            item.click()
                        }
                        ans
                    }
                    """, completionHandler: { (found: Any?, error: Error?) in
                    
                    //if nothing was found
                    if found == nil{
                        DispatchQueue.main.async{
                            //make sure bot is still running
                            if self.requestWebView?.botRunning == true{
                                //if there are more items, skip this one and go to next
                                if self.currentItem != self.numItems{
                                    self.startNext()
                                }else{
                                    //If this was the only item, refresh the page and start over
                                    self.requestWebView?.supremeBrowser?.evaluateJavaScript("location.reload(true)", completionHandler: nil)
                                    let ranRefresh = Int.random(in: 850 ... 1000)
                                    let browserDelayQ2 = DispatchQueue(label: "browswerBackgroundQ2", qos: .userInitiated)
                                    browserDelayQ2.asyncAfter(deadline: .now() + .milliseconds(ranRefresh))
                                    {
                                        self.findItem()
                                    }
                                }
                            }
                        }
                    //if text was returned
                    }else{
                        let foundStr = found as! String
                        
                        //if the word "found" was returned (will be if item was found)
                        if foundStr.contains("Found"){
                            let browserDelayQFound = DispatchQueue(label: "browserDelayQFound", qos: .userInitiated)
                            browserDelayQFound.asyncAfter(deadline: .now() + .milliseconds(100))
                            {
                                print(foundStr)
                                
                                self.cartButton()
                            }
                        }else{
                            //if something else was returned (shouldnt happen)
                            //does same as above (if only item, refresh and keep trying. if more items, skip this one)
                            DispatchQueue.main.async{
                                if self.requestWebView?.botRunning == true{
                                    if self.currentItem != self.numItems{
                                        self.startNext()
                                    }else{
                                        //wait for new drop to load
                                        print("Waiting For Category To Load")
                                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("location.reload(true)", completionHandler: nil)
                                        let browserDelayQ2 = DispatchQueue(label: "browswerBackgroundQ2", qos: .userInitiated)
                                        let ranRefresh = Int.random(in: 850 ... 1000)
                                        browserDelayQ2.asyncAfter(deadline: .now() + .milliseconds(ranRefresh))
                                        {
                                            self.findItem()
                                        }
                                    }
                                }
                            }

                        }
                    }
                
                })
            }
        }
        }
    
    //make sure "add to cart" button has loaded
    func cartButton(){
        DispatchQueue.main.async{
            print(self.ccType)
            //get add to cart button text
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementsByClassName('cart-button')[0].innerText",
                                                                    completionHandler:
                { (length: Any?, error: Error?) in
                    if length == nil{
                        //button has not loaded
                        self.cartButton()
                    }else{
                        //add to cart button loaded, we can continue
                        print("Loaded")
                        //pass current URL to next funciton
                        let url = self.requestWebView?.supremeBrowser?.url
                        self.getItemInfo(currentURL: url!)
                    }
            })
        }
    }

    //get json file of current item
    func getItemInfo(currentURL: URL){
        
        //get item number from the url
        let itemURL = currentURL.absoluteString
        let tmpNum = itemURL.components(separatedBy: "/")
        let finalStr = tmpNum.count
        let itemNum = tmpNum[(finalStr - 1)]

        //get the json url
        let jsonFile = "https://www.supremenewyork.com/shop/" + itemNum + ".json"
        var jsonData = ""
        var jsonFData: Data
        
        //attempt to get json data
        if let url = URL(string: jsonFile) {
            do {
                jsonData = try String(contentsOf: url)
                jsonFData = jsonData.data(using: .utf8)!
                self.intJson(jsonFData: jsonFData)
            } catch {
                print("oh no...")
                self.getItemInfo(currentURL: currentURL)
            }
        }
    }
    
    //find size and color values from json
    func intJson(jsonFData: Data){
        
        print("Finding Size & Color")
        
        //Keep track of everything from the JSON file
        var arraySizeName = [String]()
        var arraySizeStock = [String]()
        var arraySizeID = [String]()
        var dictStyle = [String: Int]()
        var dictSizes = [String: String]()
        var dictStock = [String: Int]()
        
        do {
            let json = try JSON(data: jsonFData)
            
            //create dictionary of style id, name, and stock
            for item in json["styles"].arrayValue {
                
                dictStyle[(item["name"].stringValue)] = Int((item["id"].stringValue))
                
                for innerItem in item["sizes"].arrayValue {
                    arraySizeName.append(innerItem["name"].stringValue)
                    arraySizeStock.append(innerItem["stock_level"].stringValue)
                    arraySizeID.append(innerItem["id"].stringValue)
                }
            }
            //look for matching color name (if color is n/a then it doesnt matter,)
            for (name, id) in dictStyle{
                if name.lowercased().contains(W2CColor) || W2CColor == "n/a"{
                    
                    //convert id to correct formatting
                    print("Color:", name, " Color ID:", id)
                    let selectedStyle = "style-" + String(id)
                    
                    //select color on website
                    let browserDelayQColor = DispatchQueue(label: "browserDelayQColor", qos: .userInitiated)
                    browserDelayQColor.asyncAfter(deadline: .now() + .milliseconds(75))
                    {
                        DispatchQueue.main.async {
                            self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(selectedStyle)\").getElementsByClassName('style-thumb')[0].dispatchEvent(event)", completionHandler: nil)
                            
                            self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(selectedStyle)\").getElementsByClassName('style-thumb')[0].click()", completionHandler: nil)
                        }
                    }
                    //create dictionary of sizes
                    for item in json["styles"].arrayValue {
                        if (item["name"].stringValue) == name{
                            for innerItem in item["sizes"].arrayValue {
                                dictSizes[(innerItem["name"].stringValue)] = (innerItem["id"].stringValue)
                                dictStock[(innerItem["name"].stringValue)] = Int((innerItem["stock_level"].stringValue))
                            }
                            
                        }
                    }
                    //look for matching size
                    for (sName, sID) in dictSizes{
                        if sName.lowercased() == (W2CSize){
                            print("Size:", sName, "Size ID:", sID)
                            //make sure size is in stock
                            if dictStock[sName] == 0{
                                print("OOS")
                                self.stopProcess()
                            }else{
                                print("In Stock")
                                //select size on site and dispatchEvent to make it display changes
                                let browserDelayQ3 = DispatchQueue(label: "browswerBackgroundQ3", qos: .userInitiated)
                                browserDelayQ3.asyncAfter(deadline: .now() + .milliseconds(140))
                                {
                                    DispatchQueue.main.async{
                                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementsByTagName('select')[0].value = \"\((sID))\"", completionHandler: nil)
                                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementsByTagName('select')[0].dispatchEvent(event)", completionHandler: nil)
                                    }
                                }
                                let browserDelayQ4 = DispatchQueue(label: "browswerBackgroundQ4", qos: .userInitiated)
                                browserDelayQ4.asyncAfter(deadline: .now() + .milliseconds(222))
                                {
                                    self.addToCart()
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
    }
        
        
    //add the item to the cart
    func addToCart()
    {
        print("Adding To Cart")
        DispatchQueue.main.async{
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("""
                atcBtn = document.getElementsByClassName("cart-button")[0];
                atcBtn.click();
            """, completionHandler: nil)

            let browserDelayQ5 = DispatchQueue(label: "browswerBackgroundQ5", qos: .userInitiated)
            browserDelayQ5.asyncAfter(deadline: .now() + .milliseconds(self.delayCheckoutClick))
            {
                print("Added To Cart")
                self.isInCart()
            }
        }
    }
    
    //make sure item is in cart
    func isInCart(){
        //get the 'add to cart' button text
        DispatchQueue.main.async{
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('cart-update').children[0].innerHTML",
                                                                completionHandler:
                { (style: Any?, error: Error?) in
                
                    if style == nil{
                        self.isInCart()
                    }else{
                        let strStyle = (style as! String)
                        //if the button says 'remove', then the item is in the cart
                        if strStyle == "remove" {
                            if self.currentItem != self.numItems{
                                self.startNext()
                            }else{
                                self.checkoutButton()
                            }
                        }else{
                                print("Waiting")
                                self.isInCart()
                        }
                    }
            })
        }
    }
    
    
    //navigate to checkout page
    func checkoutButton(){
        //again, double check that the add to cart button now reads 'remove'
        DispatchQueue.main.async{
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('cart-update').children[0].innerHTML",
                                                                    completionHandler:
                { (style: Any?, error: Error?) in
                    
                    if style == nil{
                        self.checkoutButton()
                    }else{
                        let strCartStyle = (style as! String)
                        //if item definitly in cart, navigate to checkout form with a random delay
                        if strCartStyle == "remove" {
                            let ranDelayCheckout = Int.random(in: 70 ... 100)
                            let browserDelayQ6 = DispatchQueue(label: "browswerBackgroundQ6", qos: .userInitiated)
                            browserDelayQ6.asyncAfter(deadline: .now() + .milliseconds(ranDelayCheckout))
                            {
                                DispatchQueue.main.async{
                                self.requestWebView?.supremeBrowser?.evaluateJavaScript("window.location.href = 'https://www.supremenewyork.com/mobile/#checkout';", completionHandler: nil)
                                }
                            }
                            if self.requestWebView?.botRunning == true{
                                self.canPaste()
                            }else{
                                self.stopProcess()
                            }

                        }else{
                            self.checkoutButton()
                        }
                    }
            })
        }
    }

    //make sure the form has loaded
    func canPaste(){
        //check if the 'submit' button exists
        DispatchQueue.main.async{
            
            self.requestWebView?.supremeBrowser?.evaluateJavaScript("""
            let checkoutBtn = document.getElementById("submit_button");
            checkoutBtn
            """,
                                                                    completionHandler:
                { (loaded: Any?, error: Error?) in
                    
                    if loaded == nil{
                        self.canPaste()
                    }else{
                        //if button exists, begin to checkout
                        print("Cart Loaded")
                        let ranDelayPaste = Int.random(in: 125 ... 175)
                        let browserDelayQ7 = DispatchQueue(label: "browswerBackgroundQ7", qos: .userInitiated)
                        browserDelayQ7.asyncAfter(deadline: .now() + .milliseconds(ranDelayPaste))
                        {
                            self.pasteInfo()
                        }
                    }
            })
        }
        
    }
        
    //FUNCTION PASTEINFO - paste profile information into checkout screen
    func pasteInfo()
    {
        print("Submitting Information")
        
        //make sure all information is provided to avoid problems
        if uName.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Name")
            }
            self.stopProcess()
            return
        }
        if uEmail.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Email")
            }
            self.stopProcess()
            return
        }
        if uPhone.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Phone")
            }
            self.stopProcess()
            return
        }
        if uAddress.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Address")
            }
            self.stopProcess()
            return
        }
        
        if uAddress2.isEmpty{
            addressPt2 = false
        }else{
            addressPt2 = true
        }
        
        if uCity.isEmpty{
            DispatchQueue.main.async{
                print("Missing: City")
            }
            self.stopProcess()
            return
        }
        if uState.isEmpty{
            DispatchQueue.main.async{
                print("Missing: State")
            }
            self.stopProcess()
            return
        }
        if uZip.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Zip")
            }
            self.stopProcess()
            return
        }
        if uCCNum.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Credit Card Number")
            }
            self.stopProcess()
            return
        }
        if uCCMonth.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Credit Card Month")
            }
            self.stopProcess()
            return
        }
        if uCCYear.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Credit Card Year")
        }
            self.stopProcess()
            return
        }
        if uCCCVV.isEmpty{
            DispatchQueue.main.async{
                print("Missing: Credit Card CVV")
            }
            self.stopProcess()
            return
        }
        
        //begin filling out the form
        
        //name
        let browserDelayQ8 = DispatchQueue(label: "browswerBackgroundQ8", qos: .userInitiated)
        browserDelayQ8.asyncAfter(deadline: .now() + .milliseconds(150))
        {
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idName))\").focus()", completionHandler: nil)
                    
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idName))\').value = \"\(String(self.uName))\"", completionHandler: nil)
                    
            }
        }
            
        //email
        let browserDelayQ9 = DispatchQueue(label: "browswerBackgroundQ9", qos: .userInitiated)
        browserDelayQ9.asyncAfter(deadline: .now() + .milliseconds(200))
        {
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idEmail))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idEmail))\').value = \"\(String(self.uEmail))\"", completionHandler: nil)
            }
        }
        
        //phone
        let browserDelayQ10 = DispatchQueue(label: "browserDelayQ10", qos: .userInitiated)
        browserDelayQ10.asyncAfter(deadline: .now() + .milliseconds(250))
        {
            DispatchQueue.main.async{
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idPhone))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idPhone))\').value = \"\(String(self.uPhone))\"", completionHandler: nil)
            }
        }
        
        //address
        let browserDelayQ11 = DispatchQueue(label: "browswerBackgroundQ11", qos: .userInitiated)
        browserDelayQ11.asyncAfter(deadline: .now() + .milliseconds(300))
        {
            DispatchQueue.main.async{
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idAddress1))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idAddress1))\').value = \"\(String(self.uAddress))\"", completionHandler: nil)
                
                if self.addressPt2 == true{
                    self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idAddress2))\').focus()", completionHandler: nil)
                    
                    self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idAddress2))\').value = \"\(String(self.uAddress2))\"", completionHandler: nil)
                    
                }else{
                    self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idAddress2))\').focus()", completionHandler: nil)
                    
                    self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idAddress2))\').value = '' ", completionHandler: nil)
                    
                }
            }
        }
        
        //zip
        let browserDelayQ12 = DispatchQueue(label: "browswerBackgroundQ12", qos: .userInitiated)
        browserDelayQ12.asyncAfter(deadline: .now() + .milliseconds(350))
        {
            DispatchQueue.main.async{
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idZip))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idZip))\').value = \"\(String(self.uZip))\"", completionHandler: nil)
            }
        }
        
        //city
        let browserDelayQ13 = DispatchQueue(label: "browswerBackgroundQ13", qos: .userInitiated)
        browserDelayQ13.asyncAfter(deadline: .now() + .milliseconds(400))
        {
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idCity))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCity))\').value = \"\(String(self.uCity))\"", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"remember_address\").checked = false", completionHandler: nil)
                
            }
        }
        
        //country / state
        let browserDelayQ14 = DispatchQueue(label: "browswerBackgroundQ14", qos: .userInitiated)
        browserDelayQ14.asyncAfter(deadline: .now() + .milliseconds(450))
        {
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idCountry))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCountry))\').value = \"\(String(self.location))\"", completionHandler: nil)
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCountry))\').dispatchEvent(event)", completionHandler: nil)
                
            }
        }
        
        //credit card type
        let browserDelayQ15 = DispatchQueue(label: "browswerBackgroundQ15", qos: .userInitiated)
        browserDelayQ15.asyncAfter(deadline: .now() + .milliseconds(480))
        {
            DispatchQueue.main.async{
                if (self.location == "GB" || self.location == "NB" || self.location == "AT" || self.location == "NB" || self.location == "AT" || self.location == "BY" || self.location == "BE" || self.location == "BG" || self.location == "HR" || self.location == "CZ" || self.location == "DK" || self.location == "EE" || self.location == "FI" || self.location == "FR" || self.location == "DE" || self.location == "GR" || self.location == "HU" || self.location == "IS" || self.location == "IE" || self.location == "IT" || self.location == "LV" || self.location == "LT" || self.location == "LU" || self.location == "MC" || self.location == "NL" || self.location == "NO" || self.location == "PL" || self.location == "PT" || self.location == "RO" || self.location == "RU" || self.location == "SK" || self.location == "SI" || self.location == "ES" || self.location == "SE" || self.location == "CH" || self.location == "TR"){
                    if (self.ccType == "Visa"){
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').focus()", completionHandler: nil)
                        
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').value = 'visa'", completionHandler: nil)
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').dispatchEvent(event)", completionHandler: nil)
                        
                    }else if (self.ccType == "American Express"){
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').focus()", completionHandler: nil)
                        
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').value = 'american_express'", completionHandler: nil)
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').dispatchEvent(event)", completionHandler: nil)
                        
                        
                    }else if (self.ccType == "Mastercard"){
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').focus()", completionHandler: nil)
                        
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').value = 'master'", completionHandler: nil)
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').dispatchEvent(event)", completionHandler: nil)
                        
                        
                    }else if (self.ccType == "Solo"){
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').focus()", completionHandler: nil)
                        
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').value = 'solo'", completionHandler: nil)
                        self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCType))\').dispatchEvent(event)", completionHandler: nil)
                        
                        
                    }else{
                        self.stopProcess()
                    }
                }
            }
        }
        
        
        //credit card number
        let browserDelayQ16 = DispatchQueue(label: "browswerBackgroundQ16", qos: .userInitiated)
        browserDelayQ16.asyncAfter(deadline: .now() + .milliseconds(610)){
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idCC))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCC))\').value = \"\(String(self.uCCNum))\"", completionHandler: nil)
                
            }
        }
        
        //credit card month
        let browserDelayQ17 = DispatchQueue(label: "browswerBackgroundQ17", qos: .userInitiated)
        browserDelayQ17.asyncAfter(deadline: .now() + .milliseconds(660)){
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"\(String(self.idCCM))\").focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCM))\').value = \"\(String(self.uCCMonth))\"", completionHandler: nil)
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCM))\').dispatchEvent(event)", completionHandler: nil)
                
            }
        }
        
        //credit card year
        let browserDelayQ18 = DispatchQueue(label: "browswerBackgroundQ18", qos: .userInitiated)
        browserDelayQ18.asyncAfter(deadline: .now() + .milliseconds(710)){
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCY))\').focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCY))\').value = \"\(String(self.uCCYear))\"", completionHandler: nil)
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCCY))\').dispatchEvent(event)", completionHandler: nil)
                
            }
        }
        
        //credit card cvv
        let browserDelayQ19 = DispatchQueue(label: "browswerBackgroundQ19", qos: .userInitiated)
        browserDelayQ19.asyncAfter(deadline: .now() + .milliseconds(760))
        {
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementsByName('\(String(self.idCVV))\')[0].focus()", completionHandler: nil)
                
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementsByName('\(String(self.idCVV))\')[0].value = \"\(String(self.uCCCVV))\"", completionHandler: nil)
                
            }
        }
        
        //order terms
        let browserDelayQ20 = DispatchQueue(label: "browswerBackgroundQ20", qos: .userInitiated)
        browserDelayQ20.asyncAfter(deadline: .now() + .milliseconds(810))
        {
            DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById('\(String(self.idCVV))\').blur()", completionHandler: nil)
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"order_terms\").checked = true", completionHandler: nil)
                
                
            }
        }

        //check if atc is enabled
        if (atc == true){
            //760ms to fill out form + delay provided
            finalDelay = 760 + atcDelay
            
            print("Checkout Delay:", String(finalDelay))
            
            //click the checkout button
            print("Final Delay:" + String(finalDelay))
            let browserDelayQ21 = DispatchQueue(label: "browswerBackgroundQ21", qos: .userInitiated)
            browserDelayQ21.asyncAfter(deadline: .now() + .milliseconds(finalDelay))
            {
                DispatchQueue.main.async{
                self.requestWebView?.supremeBrowser?.evaluateJavaScript("document.getElementById(\"hidden_cursor_capture\").click()", completionHandler: nil)

                }
            }

        }
        
        //find the time to stop the bot
        var finishtime = 0
        if (atc == true){
            finishtime = finalDelay
        }else{
            finishtime = 725
        }
        
        //bot now complete
        let browserDelayQ22 = DispatchQueue(label: "browswerBackgroundQ22", qos: .userInitiated)
        browserDelayQ22.asyncAfter(deadline: .now() + .milliseconds(finishtime))
        {
            self.stopProcess()
        }
    }
    
    deinit
    {
        self.stopProcess()
    }
}




