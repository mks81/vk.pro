//
//  Likes.swift
//  vk.pro
//
//  Created by Konstantin Mikhailov on 26/05/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

class LikesControl: UIControl {
    
    var alreadyLiked = false
    var likesCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let heartSize = rect.height
        let path = UIBezierPath()
        let sideOne = heartSize * 0.4
        let sideTwo = heartSize * 0.3
        let arcRadius = sqrt(sideOne * sideOne + sideTwo * sideTwo) / 2
        path.addArc(withCenter: CGPoint(x: heartSize * 0.3, y: heartSize * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        path.addArc(withCenter: CGPoint(x: heartSize * 0.7, y: heartSize * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        path.addLine(to: CGPoint(x: heartSize * 0.5, y: heartSize * 0.95))
        path.close()
        
        UIColor.red.setFill()
        UIColor.red.setStroke()
        
        alreadyLiked ? path.fill() : path.stroke()
        
        

    }
    
    func setup() {
        
        addTarget(self, action: #selector(changeState), for: .touchUpInside)
        
        alpha = 0.8
        backgroundColor = .gray
        //layer.borderWidth = 1
        //layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = frame.height / 4
        clipsToBounds = true
    }
    
    @objc func changeState() {
        if alreadyLiked {
            likesCount -= 1
        } else {
            likesCount += 1
        }
        alreadyLiked.toggle()
        setNeedsDisplay()
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
