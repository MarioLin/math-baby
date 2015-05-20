//
//  UINavigationController+Retro.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/20/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func pushViewControllerRetro(viewController:UIViewController) {
    var transition = CATransition();
    transition.duration = 0.25;
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    self.view.layer.addAnimation(transition, forKey: nil)
    
    self.pushViewController(viewController, animated: true)
    }
    
    func popViewControllerRetro(viewController:UIViewController) {
        var transition = CATransition();
        transition.duration = 0.25;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        self.view.layer.addAnimation(transition, forKey: nil)
        
        self.popViewControllerAnimated(true)
    }
    
    func popToRootViewControllerRetro(viewController:UIViewController) {
        var transition = CATransition();
        transition.duration = 0.25;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        self.view.layer.addAnimation(transition, forKey: nil)
        
        self.popToRootViewControllerAnimated(true)
    }
}