//
//  News.swift
//  vk.pro
//
//  Created by mks on 08/08/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import ObjectMapper
import RealmSwift

class News: Object, Mappable {
    @objc dynamic var attachmentPhoto: String = ""
    @objc dynamic var attachmentsType: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var date: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var sourceAvatar: String = ""
    @objc dynamic var sourceName: String = ""
    @objc dynamic var sourceId: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {

        type <- map["type"]
        sourceId <- map["source_id"]
        date <- map["date"]
        text <- map["text"]
        attachmentsType <- map["attachments.0.type"]
        attachmentPhoto <- map["attachments.0.photo.sizes.2.url"]
    }
    
    override static func primaryKey() -> String? {
        return "sourceId"
    }
}
