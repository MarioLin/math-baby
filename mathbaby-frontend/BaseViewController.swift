//
//  UIViewControllerExtension.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/20/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let backgroundFilterView = UIView(frame: self.view.frame)
        backgroundFilterView.backgroundColor = UIColor.backgroundColor()
        backgroundFilterView.alpha = 0.6
        self.view.addSubview(backgroundFilterView)
        self.view.sendSubviewToBack(backgroundFilterView)
        
        let backgroundImgView = UIImageView(frame: CGRectMake(0, 20, (self.view.frame.height-20)*1.6, self.view.frame.height-20))
        backgroundImgView.backgroundColor = UIColor.clearColor()
        backgroundImgView.image = UIImage(named: "background")
        self.view.addSubview(backgroundImgView)
        self.view.sendSubviewToBack(backgroundImgView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}