//
//  CustomRefreshControl.swift
//  vk.pro
//
//  Created by mks on 21/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class CustomRefreshControl: UIRefreshControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        backgroundColor = .clear
        tintColor = .clear
        
        let path = UIBezierPath()
        
        let heartSize = frame.height / 1.5
        //path.lineWidth = 1
        let sideOne = heartSize * 0.4
        let sideTwo = heartSize * 0.3
        let arcRadius = sqrt(sideOne * sideOne + sideTwo * sideTwo) / 2
        path.addArc(withCenter: CGPoint(x: heartSize * 0.3, y: heartSize * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        path.addArc(withCenter: CGPoint(x: heartSize * 0.7, y: heartSize * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        path.addLine(to: CGPoint(x: heartSize * 0.5, y: heartSize * 0.95))
        path.close()
        let move = (frame.height - heartSize) / 2
        path.apply(CGAffineTransform(translationX: move, y: move))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        

        
        
        
        
        shape.lineWidth = 3
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        
        layer.addSublayer(shape)
        
        let strokeEnd = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEnd.fromValue = 0
        strokeEnd.toValue = 1.1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.animations = [strokeEnd]
        animationGroup.repeatCount = .infinity
        
        shape.add(animationGroup, forKey: nil)
        
        
        
        

    }
    
    override func draw(_ rect: CGRect) {
 
    }


}
