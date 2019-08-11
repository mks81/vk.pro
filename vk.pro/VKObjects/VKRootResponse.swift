//
//  VKRootResponse.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 24/07/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import ObjectMapper

class VKRootResponse: Mappable {
    var users: [User] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        users <- map["response"]
    }
}
