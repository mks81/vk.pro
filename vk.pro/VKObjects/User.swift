//
//  User.swift
//  vk.pro
//
//  Created by mks on 06/07/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var id: Int = 0
    var photo: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        photo <- map["photo_50"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
    }
}
