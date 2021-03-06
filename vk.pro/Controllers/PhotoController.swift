//
//  PhotoController.swift
//  vk.pro
//
//  Created by mks on 17/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {

    var photos: [String] = ["phuket", "den", "durov", "ira", "kreml", "kreml1", "musk", "nadya", "book", "putin", "buterin"]
    var animationInProgress = false
    var index = 0
    var hiddenImageIndex = 1
    var photo = ""
    var imageViews: [UIImageView] = [UIImageView(), UIImageView()]
    
    var frameWidth: CGFloat = 0.0
    var frameHeight: CGFloat = 0.0
    
    let scale: CGFloat = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameWidth = view.bounds.width
        frameHeight = view.bounds.height
        
        let image = UIImage(named: photos[0])
        imageViews[0] = UIImageView(image: image)
        let imageHeight = getImageHight(imageSource: image!)
        imageViews[0].frame = CGRect(x: 0, y: (frameHeight - imageHeight) / 2, width: frameWidth, height: imageHeight)
        view.addSubview(imageViews[0])
        
        let swipeLeft =  UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    func getImageHight(imageSource: UIImage) -> CGFloat {
        let photoWidth = imageSource.size.width
        let photoHeight = imageSource.size.height
        let ratio = frameWidth / photoWidth
        let imageHeight = photoHeight * ratio
        
        return imageHeight
    }
    
    func listAnimation(left: Bool) {
        if animationInProgress { return }
        animationInProgress = true
        let value = left ? 1 : -1
     
        let swipeLeftExpression = self.index < self.photos.count - 1
        let swipeRightExpression = self.index > 0
        
        let expression = left ? swipeLeftExpression : swipeRightExpression
        
        if expression {
            let image = UIImage(named: photos[index + value])
            
            imageViews[hiddenImageIndex] = UIImageView()
            imageViews[hiddenImageIndex].image = image
            let imageHeight = getImageHight(imageSource: image!)
            imageViews[hiddenImageIndex].frame = CGRect(x: frameWidth * CGFloat(value), y: (frameHeight - imageHeight) / 2, width: frameWidth, height: imageHeight)
            view.addSubview(imageViews[hiddenImageIndex])
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
                //уменьшаем отображаемую картинку
                //hiddenImageIndex ^ 1 вычисляет отображаемую картинку, либо 0, либо 1
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                    self.imageViews[self.hiddenImageIndex ^ 1].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                })
                //отодвигаем отображаемую картинку
                UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 1, animations: {
                    self.imageViews[self.hiddenImageIndex ^ 1].frame.origin.x = self.frameHeight * -CGFloat(value)
                })
                //сдвигаем новую картинку на место отображаемой
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1, animations: {
                    self.imageViews[self.hiddenImageIndex].frame.origin.x = 0
                })
            }, completion: { (true) in
                self.imageViews[self.hiddenImageIndex ^ 1].removeFromSuperview()
                self.index += value
                self.hiddenImageIndex ^= 1
                self.animationInProgress = false
            })
        } else {
            UIView.animateKeyframes(withDuration: 0.43, delay: 0, options: .calculationModeLinear, animations: {
                //уменьшаем отображаемую картинку
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                    self.imageViews[self.hiddenImageIndex ^ 1].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                })
                //возварщаем масштаб картинки
                UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.43, animations: {
                    self.imageViews[self.hiddenImageIndex ^ 1].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }, completion: { (true) in
                self.animationInProgress = false
            })
        }
    }
    
    @objc func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        listAnimation(left: true)
    }
    
    @objc func swipeRight(_ recognizer: UISwipeGestureRecognizer) {
        listAnimation(left: false)
    }
}
