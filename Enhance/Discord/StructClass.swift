//
//  StructClass.swift
//  Enhance
//
//  Created by Michael Gillund on 5/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

struct MsgListObjects
{
    let id : String
    let type : NSNumber
    let contentTextMsg : String
    let channelID : String
    let timeStamp : String
    
    
    var author : [authorSub]
    
    init(id:String, type:NSNumber, contentTextMsg:String, channelID:String, timeStamp:String, author:[authorSub])
    {
        self.id = id
        self.type = type
        self.contentTextMsg = contentTextMsg
        self.channelID = channelID
        self.timeStamp = timeStamp
    
        self.author = author
        
    }
}
struct MontiorObjects
{
    var embed : [embedSub]
    
    init(embed:[embedSub]) {
        self.embed = embed
    }
    
    
}
struct embedSub
{
    let title : String
    
    init(title:String)
    {
        self.title = title
    }
}

struct authorSub
{
    let id : String
    let userName : String
    
    init(id:String, userName:String)
    {
        self.id = id
        self.userName = userName
    }
}

struct serverListObjects
{
    let id : String
    let name : String
    
    init(id:String, name:String)
    {
        self.id = id
        self.name = name
    }
}

struct channelListObjects
{
    let id : String
    let type : NSNumber
    let name : String
    let position : NSNumber
    let parent_id : String
    let guild_id : String
    
    init(id:String, type:NSNumber, name:String, position:NSNumber, parent_id:String, guild_id:String)
    {
        self.id = id
        self.type = type
        self.name = name
        self.position = position
        self.parent_id = parent_id
        self.guild_id = guild_id
    }
}


class Structclass: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
