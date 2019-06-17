//
//  PhotoController.swift
//  vk.pro
//
//  Created by mks on 17/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {

    var index = 0
    var photos: [String] = ["book", "buterin", "den", "durov", "ira", "kreml", "kreml1", "musk", "nadya", "phuket", "putin"]
    var photo = ""
    var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos.insert(photo, at: 0)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
//        let swipeLeft =  UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        view.addGestureRecognizer(panGestureRecognizer)
//        view.addGestureRecognizer(swipeLeft)
//        view.addGestureRecognizer(swipeRight)
        
        let frameWidth = view.bounds.width
        let frameHeight = view.bounds.height
        let photoWidth = UIImage(named: photo)!.size.width
        let photoHeight = UIImage(named:photo)!.size.height
        let ratio = frameWidth / photoWidth
        
        let image = UIImage(named: photos[index])
        imageView = UIImageView(image: image)
        let imageHeight = photoHeight * ratio
        
        imageView.frame = CGRect(x: 0, y: (frameHeight - imageHeight) / 2, width: frameWidth, height: imageHeight)
        view.addSubview(imageView)
    }
    
    var animator: UIViewPropertyAnimator!
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            animator = UIViewPropertyAnimator(duration: 3, curve: .easeInOut, animations: {
                self.imageView.center.x += self.view.bounds.width
                
            })
            //break
        case .changed:
            let translation = recognizer.translation(in: view)
            //let progress = min(1, max(0, translation.x / 100))
            let progress = translation.x
            print(progress)
            animator.fractionComplete = progress
            //break
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 1)
            index += 1
            //imageView.image = UIImage(named: photos[index])
            //break
        default:
            return
        }
    }
    
//    @objc func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
//        print(#function)
//    }
//
//    @objc func swipeRight(_ recognizer: UISwipeGestureRecognizer) {
//        print(#function)
//    }
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    

}
