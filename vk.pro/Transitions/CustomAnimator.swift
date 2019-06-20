//
//  CustomAnimator.swift
//  vk.pro
//
//  Created by mks on 20/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 3
    var isPresenting: Bool = true
//    var originFrame: CGRect
//    var image: UIImage
    
//    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, image: UIImage) {
//        self.duration = duration
//        self.isPresenting = isPresenting
//        self.originFrame = originFrame
//        self.image = image
//    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        if(isPresenting) {
//            toView.frame = fromView.frame
//            toView.alpha = 0
        } else {
            toView.frame = CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
//            toView.alpha = 1
        }
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            if(self.isPresenting) {
                toView.transform = CGAffineTransform(rotationAngle: .pi * 2)
//                toView.frame = fromView.frame
//                toView.alpha = 1
                
            } else {
                fromView.frame = CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
                fromView.alpha = 0
            }
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    

}
