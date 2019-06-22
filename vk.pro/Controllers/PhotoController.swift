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
    var index = 0
    var hiddenImageIndex = 1
    var photo = ""
    var imageViews = [UIImageView]()
    
    var frameWidth: CGFloat = 0.0
    var frameHeight: CGFloat = 0.0
    
    let scale: CGFloat = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos.insert(photo, at: 0)
        
        frameWidth = view.bounds.width
        frameHeight = view.bounds.height
        
        for i in 0...1 {
            imageViews.append(UIImageView())
            
            let image = UIImage(named: photos[i])
            imageViews[i] = UIImageView(image: image)
            let imageHeight = getImageHight(imageSource: image!)
            imageViews[i].frame = CGRect(x: CGFloat(i) * frameWidth, y: (frameHeight - imageHeight) / 2, width: frameWidth, height: imageHeight)
            view.addSubview(imageViews[i])
        }
        
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
        let value = left ? 1 : -1
     
        let swipeLeftExpression = self.index < self.photos.count - 1
        let swipeRightExpression = self.index > 0
        
        let expression = left ? swipeLeftExpression : swipeRightExpression
        
        if(expression) {
            let image = UIImage(named: photos[index + value])
            imageViews[hiddenImageIndex].image = image
            let imageHeight = getImageHight(imageSource: image!)
            
            imageViews[hiddenImageIndex].frame = CGRect(x: frameWidth * CGFloat(value), y: (frameHeight - imageHeight) / 2, width: frameWidth, height: imageHeight)
            self.imageViews[hiddenImageIndex].isHidden = false
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
                //уменьшаем отображаемую картинку
                //что бы было понятней, hiddenImageIndex ^ 1 вычисляет отображаемую картинку, либо 0, либо 1
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
                self.imageViews[self.hiddenImageIndex ^ 1].isHidden = true
                self.index += value
                self.hiddenImageIndex ^= 1
            })
        } else {
            UIView.animate(withDuration: 0.33, animations: {
                self.imageViews[self.hiddenImageIndex ^ 1].transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            }) { (true) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.imageViews[self.hiddenImageIndex ^ 1].transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
    
    @objc func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        listAnimation(left: true)
    }
    
    @objc func swipeRight(_ recognizer: UISwipeGestureRecognizer) {
        listAnimation(left: false)
    }
}
