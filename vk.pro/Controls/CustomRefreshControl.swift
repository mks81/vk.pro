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
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.5, y: 46.5))
        bezierPath.addCurve(to: CGPoint(x: 14.5, y: 46.5), controlPoint1: CGPoint(x: 2.5, y: 46.5), controlPoint2: CGPoint(x: 14.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 14.5, y: 38.5))
        bezierPath.addCurve(to: CGPoint(x: 7.5, y: 35.5), controlPoint1: CGPoint(x: 14.5, y: 38.5), controlPoint2: CGPoint(x: 7.5, y: 37))
        bezierPath.addCurve(to: CGPoint(x: 13.5, y: 32.5), controlPoint1: CGPoint(x: 7.5, y: 34), controlPoint2: CGPoint(x: 13.5, y: 32.5))
        bezierPath.addCurve(to: CGPoint(x: 7.5, y: 27.5), controlPoint1: CGPoint(x: 13.5, y: 32.5), controlPoint2: CGPoint(x: 7.5, y: 28.75))
        bezierPath.addCurve(to: CGPoint(x: 13.5, y: 27.5), controlPoint1: CGPoint(x: 7.5, y: 26.25), controlPoint2: CGPoint(x: 13.5, y: 27.5))
        bezierPath.addCurve(to: CGPoint(x: 16.5, y: 18.5), controlPoint1: CGPoint(x: 13.5, y: 27.5), controlPoint2: CGPoint(x: 15.75, y: 18.5))
        bezierPath.addCurve(to: CGPoint(x: 16.5, y: 27.5), controlPoint1: CGPoint(x: 17.25, y: 18.5), controlPoint2: CGPoint(x: 16.5, y: 27.5))
        bezierPath.addCurve(to: CGPoint(x: 22.5, y: 27.5), controlPoint1: CGPoint(x: 16.5, y: 27.5), controlPoint2: CGPoint(x: 21.75, y: 26.25))
        bezierPath.addCurve(to: CGPoint(x: 19.5, y: 32.5), controlPoint1: CGPoint(x: 23.25, y: 28.75), controlPoint2: CGPoint(x: 19.5, y: 32.5))
        bezierPath.addCurve(to: CGPoint(x: 22.5, y: 38.5), controlPoint1: CGPoint(x: 19.5, y: 32.5), controlPoint2: CGPoint(x: 23.25, y: 37))
        bezierPath.addCurve(to: CGPoint(x: 16.5, y: 38.5), controlPoint1: CGPoint(x: 21.75, y: 40), controlPoint2: CGPoint(x: 16.5, y: 38.5))
        bezierPath.addLine(to: CGPoint(x: 16.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 32.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 32.5, y: 41.5))
        bezierPath.addCurve(to: CGPoint(x: 25.5, y: 41.5), controlPoint1: CGPoint(x: 32.5, y: 41.5), controlPoint2: CGPoint(x: 26.25, y: 43))
        bezierPath.addCurve(to: CGPoint(x: 29.5, y: 35.5), controlPoint1: CGPoint(x: 24.75, y: 40), controlPoint2: CGPoint(x: 29.5, y: 35.5))
        bezierPath.addCurve(to: CGPoint(x: 22.5, y: 32.5), controlPoint1: CGPoint(x: 29.5, y: 35.5), controlPoint2: CGPoint(x: 21.75, y: 33.25))
        bezierPath.addCurve(to: CGPoint(x: 32.5, y: 32.5), controlPoint1: CGPoint(x: 23.25, y: 31.75), controlPoint2: CGPoint(x: 32.5, y: 32.5))
        bezierPath.addCurve(to: CGPoint(x: 29.5, y: 24.5), controlPoint1: CGPoint(x: 32.5, y: 32.5), controlPoint2: CGPoint(x: 28.25, y: 24.5))
        bezierPath.addCurve(to: CGPoint(x: 37.5, y: 32.5), controlPoint1: CGPoint(x: 30.75, y: 24.5), controlPoint2: CGPoint(x: 37.5, y: 32.5))
        bezierPath.addCurve(to: CGPoint(x: 43.5, y: 32.5), controlPoint1: CGPoint(x: 37.5, y: 32.5), controlPoint2: CGPoint(x: 43.5, y: 31.75))
        bezierPath.addCurve(to: CGPoint(x: 37.5, y: 35.5), controlPoint1: CGPoint(x: 43.5, y: 33.25), controlPoint2: CGPoint(x: 37.5, y: 35.5))
        bezierPath.addCurve(to: CGPoint(x: 40.5, y: 41.5), controlPoint1: CGPoint(x: 37.5, y: 35.5), controlPoint2: CGPoint(x: 40.5, y: 40))
        bezierPath.addCurve(to: CGPoint(x: 34.5, y: 41.5), controlPoint1: CGPoint(x: 40.5, y: 43), controlPoint2: CGPoint(x: 34.5, y: 41.5))
        bezierPath.addLine(to: CGPoint(x: 34.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 47.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 47.5, y: 39.5))
        bezierPath.addLine(to: CGPoint(x: 47.5, y: 9.5))
        bezierPath.addLine(to: CGPoint(x: 57.5, y: 9.5))
        bezierPath.addLine(to: CGPoint(x: 57.5, y: 6.5))
        bezierPath.addLine(to: CGPoint(x: 62.5, y: 6.5))
        bezierPath.addLine(to: CGPoint(x: 62.5, y: 9.5))
        bezierPath.addLine(to: CGPoint(x: 71.5, y: 9.5))
        bezierPath.addLine(to: CGPoint(x: 71.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 80.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 80.5, y: 24.5))
        bezierPath.addCurve(to: CGPoint(x: 75.5, y: 27.5), controlPoint1: CGPoint(x: 80.5, y: 24.5), controlPoint2: CGPoint(x: 75.5, y: 28.25))
        bezierPath.addCurve(to: CGPoint(x: 80.5, y: 21.5), controlPoint1: CGPoint(x: 75.5, y: 26.75), controlPoint2: CGPoint(x: 80.5, y: 21.5))
        bezierPath.addLine(to: CGPoint(x: 82.5, y: 21.5))
        bezierPath.addLine(to: CGPoint(x: 82.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 87.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 87.5, y: 9.5))
        bezierPath.addLine(to: CGPoint(x: 103.5, y: 9.5))
        bezierPath.addLine(to: CGPoint(x: 103.5, y: 18.5))
        bezierPath.addLine(to: CGPoint(x: 120.5, y: 18.5))
        bezierPath.addLine(to: CGPoint(x: 120.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 124.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 124.5, y: 27.5))
        bezierPath.addLine(to: CGPoint(x: 141.5, y: 27.5))
        bezierPath.addLine(to: CGPoint(x: 141.5, y: 24.5))
        bezierPath.addLine(to: CGPoint(x: 157.5, y: 24.5))
        bezierPath.addLine(to: CGPoint(x: 157.5, y: 27.5))
        bezierPath.addLine(to: CGPoint(x: 175.5, y: 27.5))
        bezierPath.addLine(to: CGPoint(x: 175.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 183.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 183.5, y: 33.5))
        bezierPath.addCurve(to: CGPoint(x: 178.5, y: 27.5), controlPoint1: CGPoint(x: 183.5, y: 33.5), controlPoint2: CGPoint(x: 178.5, y: 30.25))
        bezierPath.addCurve(to: CGPoint(x: 182.5, y: 21.5), controlPoint1: CGPoint(x: 178.5, y: 24.75), controlPoint2: CGPoint(x: 182.5, y: 21.5))
        bezierPath.addCurve(to: CGPoint(x: 178.5, y: 15.5), controlPoint1: CGPoint(x: 182.5, y: 21.5), controlPoint2: CGPoint(x: 178.5, y: 17.75))
        bezierPath.addCurve(to: CGPoint(x: 182.5, y: 12.5), controlPoint1: CGPoint(x: 178.5, y: 13.25), controlPoint2: CGPoint(x: 182.5, y: 12.5))
        bezierPath.addCurve(to: CGPoint(x: 182.5, y: 6.5), controlPoint1: CGPoint(x: 182.5, y: 12.5), controlPoint2: CGPoint(x: 181.5, y: 5.75))
        bezierPath.addCurve(to: CGPoint(x: 186.5, y: 15.5), controlPoint1: CGPoint(x: 183.5, y: 7.25), controlPoint2: CGPoint(x: 186.5, y: 15.5))
        bezierPath.addCurve(to: CGPoint(x: 189.5, y: 18.5), controlPoint1: CGPoint(x: 186.5, y: 15.5), controlPoint2: CGPoint(x: 189.5, y: 17))
        bezierPath.addCurve(to: CGPoint(x: 186.5, y: 21.5), controlPoint1: CGPoint(x: 189.5, y: 20), controlPoint2: CGPoint(x: 186.5, y: 21.5))
        bezierPath.addCurve(to: CGPoint(x: 189.5, y: 27.5), controlPoint1: CGPoint(x: 186.5, y: 21.5), controlPoint2: CGPoint(x: 189.5, y: 24.75))
        bezierPath.addCurve(to: CGPoint(x: 185.5, y: 32.5), controlPoint1: CGPoint(x: 189.5, y: 30.25), controlPoint2: CGPoint(x: 185.5, y: 32.5))
        bezierPath.addLine(to: CGPoint(x: 185.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 190.5, y: 46.5))
        bezierPath.addCurve(to: CGPoint(x: 188.5, y: 42.5), controlPoint1: CGPoint(x: 190.5, y: 46.5), controlPoint2: CGPoint(x: 187.75, y: 43.75))
        bezierPath.addCurve(to: CGPoint(x: 192.5, y: 41.5), controlPoint1: CGPoint(x: 189.25, y: 41.25), controlPoint2: CGPoint(x: 192.5, y: 41.5))
        bezierPath.addCurve(to: CGPoint(x: 192.5, y: 38.5), controlPoint1: CGPoint(x: 192.5, y: 41.5), controlPoint2: CGPoint(x: 191.75, y: 39.25))
        bezierPath.addCurve(to: CGPoint(x: 195.5, y: 38.5), controlPoint1: CGPoint(x: 193.25, y: 37.75), controlPoint2: CGPoint(x: 194.75, y: 37.75))
        bezierPath.addCurve(to: CGPoint(x: 195.5, y: 41.5), controlPoint1: CGPoint(x: 196.25, y: 39.25), controlPoint2: CGPoint(x: 195.5, y: 41.5))
        bezierPath.addCurve(to: CGPoint(x: 198.5, y: 41.5), controlPoint1: CGPoint(x: 195.5, y: 41.5), controlPoint2: CGPoint(x: 197.75, y: 40.25))
        bezierPath.addCurve(to: CGPoint(x: 197.5, y: 46.5), controlPoint1: CGPoint(x: 199.25, y: 42.75), controlPoint2: CGPoint(x: 197.5, y: 46.5))
        bezierPath.addLine(to: CGPoint(x: 201.5, y: 46.5))
        
        let shape = CAShapeLayer()
        shape.path = bezierPath.cgPath
        
        shape.lineWidth = 2
        shape.strokeColor = UIColor.gray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        
        layer.addSublayer(shape)
        
        let strokeEnd = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEnd.fromValue = 0
        strokeEnd.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3
        animationGroup.animations = [strokeEnd]
        animationGroup.repeatCount = .infinity
        
        shape.add(animationGroup, forKey: nil)
    }
    
    override func draw(_ rect: CGRect) {
 
    }


}
