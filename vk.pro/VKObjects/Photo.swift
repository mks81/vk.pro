//
//  Photo.swift
//  vk.pro
//
//  Created by mks on 06/07/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import ObjectMapper

class Photo: Mappable {
    var id: Int = 0
    var likes: [String: Int] = [:]
    var sizes: [Sizes] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        likes <- map["likes"]
        sizes <- map["sizes"]
    }
}

class Sizes: Mappable {

    var url: String = ""
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        url <- map["url"]
    }
}
