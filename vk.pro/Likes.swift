//
//  Likes.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 26/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class Likes: UIControl {
    
    var like = Int.random(in: 0...100)
    var liked = Bool.random()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initLikes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLikes()
    }
    
    private func initLikes() {
        //backgroundColor = .blue
        //label.text = String(like)
        //image.image = liked ? UIImage(named: "like-filled") : UIImage(named: "like")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
