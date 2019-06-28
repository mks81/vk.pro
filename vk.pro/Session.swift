//
//  Session.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 27/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class Session {
    static let instance = Session()
    
    var token: String = ""
    var userId: Int = 0
    
    private init() {}
}
