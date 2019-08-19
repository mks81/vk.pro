//
//  NewsProfile.swift
//  vk.pro
//
//  Created by mks on 19/08/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import ObjectMapper
import RealmSwift

class NewsProfile: Object, Mappable {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        photo <- map["photo_50"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

