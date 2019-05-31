//
//  AvatarView.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 26/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowRadius: CGFloat = 4
    @IBInspectable var shadowOpacity: Float = 0.9

    @IBOutlet weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = frame.height / 2
        imageView.clipsToBounds = true
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: frame.size.height / 2).cgPath
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
