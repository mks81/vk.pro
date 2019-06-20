//
//  CustomNavigationController.swift
//  vk.pro
//
//  Created by mks on 20/06/2019.
//  Copyright © 2019 Nikota. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let transitionAnimator = CustomAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return transitionAnimator
        case .pop:
            return transitionAnimator
        default:
            return nil
        }
    }

}
