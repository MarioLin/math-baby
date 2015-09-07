//
//  SelectGameScrollViewController.swift
//  mathbaby-frontend
//
//  Created by Mario Lin on 9/6/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit
class SelectGameScrollViewController: BaseViewController {
    
    @IBOutlet var containerView: UIView!
    override func viewDidLoad() {
        self.view.addSubview(containerView)

        let childView = storyboard?.instantiateViewControllerWithIdentifier("LevelSelectContainerViewController") as! UIPageViewController
        self.addChildViewController(childView)
        childView.view.frame = self.containerView.frame
        self.containerView.addSubview(childView.view)
        childView.didMoveToParentViewController(self)
    }
}