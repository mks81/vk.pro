//
//  Group.swift
//  vk.pro
//
//  Created by mks on 06/07/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import ObjectMapper

class Group: Mappable {
    var id: Int = 0
    var photo: String = ""
    var name: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        photo <- map["photo_50"]
        name <- map["name"]
    }
}
