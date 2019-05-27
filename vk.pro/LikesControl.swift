//
//  Likes.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 26/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

protocol photoCellCommunicationDelegate: class {

    func trackingEnded()
}


class LikesControl: UIControl {
    
    weak var delegate: photoCellCommunicationDelegate?
    
    override func layoutSubviews() {
        alpha = 0.8
        backgroundColor = .gray
        layer.cornerRadius = frame.height / 4
        clipsToBounds = true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {

        delegate?.trackingEnded()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
