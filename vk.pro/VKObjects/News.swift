//
//  News.swift
//  vk.pro
//
//  Created by mks on 08/08/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class News: Object, Mappable {
    @objc dynamic var sourceId: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var date: Int = 0
    //@objc dynamic var postType: String = ""
    @objc dynamic var text: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        //type post
        type <- map["type"]
        switch type {
        case "post":
            sourceId <- map["source_id"]
            date <- map["date"]
            //postType <- map["post_type"]
            text <- map["text"]
        default:
            return
        }

    }
    
    override static func primaryKey() -> String? {
        return "sourceId"
    }
}
