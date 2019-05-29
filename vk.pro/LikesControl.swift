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
        
        let heartSize = rect.height / 1.5
        let path = UIBezierPath()
        path.lineWidth = 1
        let sideOne = heartSize * 0.4
        let sideTwo = heartSize * 0.3
        let arcRadius = sqrt(sideOne * sideOne + sideTwo * sideTwo) / 2
        path.addArc(withCenter: CGPoint(x: heartSize * 0.3, y: heartSize * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        path.addArc(withCenter: CGPoint(x: heartSize * 0.7, y: heartSize * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        path.addLine(to: CGPoint(x: heartSize * 0.5, y: heartSize * 0.95))
        path.close()
        let move = (rect.height - heartSize) / 2
        path.apply(CGAffineTransform(translationX: move, y: move))
        
        UIColor.red.setFill()
        UIColor.white.setStroke()
        //label.white
        if alreadyLiked {
            UIColor.red.setStroke()
            path.fill()
            //label.red
        }
        path.stroke()

    }
    
    func setup() {
        
        addTarget(self, action: #selector(changeState), for: .touchUpInside)

        backgroundColor = UIColor(red: 0, green: 128, blue: 128, alpha: 0.3)
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
