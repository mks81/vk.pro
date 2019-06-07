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
    
    // !!!! Почему не отображаются в сториборд? !!!!
    @IBInspectable var strokeColor: UIColor = UIColor.white
    @IBInspectable var fillColor: UIColor = UIColor.red
    @IBInspectable var bgAlpha: CGFloat = 0.3
    @IBInspectable var bgColor: UIColor = UIColor.cyan
    @IBInspectable var background: Bool = true
    
    @IBOutlet weak var likeLebel: UILabel!
    
    var alreadyLiked = Bool.random()
    var likesCount = Int.random(in: 0...99)
    
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
        
        backgroundColor = background ? bgColor.withAlphaComponent(bgAlpha) : .clear
        fillColor.setFill()
        strokeColor.setStroke()
        likeLebel.textColor = strokeColor
        likeLebel.text = String(likesCount)
        if alreadyLiked {
            fillColor.setStroke()
            path.fill()
            likeLebel.textColor = fillColor
        }
        path.stroke()
    }
    
    func setup() {
        
        addTarget(self, action: #selector(changeState), for: .touchUpInside)

        layer.cornerRadius = frame.height / 4
        clipsToBounds = true
    }
    
    @objc func changeState() {
        var scale: CGFloat = 1.5
        if alreadyLiked {
            scale = 0.67
            likesCount -= 1
        } else {
            likesCount += 1
        }
        alreadyLiked.toggle()
        setNeedsDisplay()
        
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }

    override func layoutSubviews() {
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
