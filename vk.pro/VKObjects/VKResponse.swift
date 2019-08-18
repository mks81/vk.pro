//
//  VKResponse.swift
//  vk.pro
//
//  Created by mks on 06/07/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import ObjectMapper

class VKResponse: Mappable {
    var items: VKResponseItems? = nil
    var users: [User] = []
    var group: [Group] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        items <- map["response"]
        users <- map["response"]
        group <- map["response"]
    }
}

class VKResponseItems: Mappable {
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
