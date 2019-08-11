//
//  VKResponse.swift
//  vk.pro
//
//  Created by mks on 06/07/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit
import ObjectMapper

class VKResponse: Mappable {
    var response: VKResponseInternal? = nil
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class VKResponseInternal: Mappable {
    var groups: [Group] = []
    var users: [User] = []
    var photos: [Photo] = []
    var news: [News] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        groups <- map["items"]
        users <- map["items"]
        photos <- map["items"]
        news <- map["items"]
    }
}
