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
    var leftCornerImgView : UIImageView!
    var rightCornerImgView : UIImageView!
    var leftCornerLowerImgView : UIImageView!
    var rightCornerLowerImgView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let backgroundFilterView = UIView(frame: self.view.frame)
        backgroundFilterView.backgroundColor = UIColor.yellowBeigeColor()
        self.view.addSubview(backgroundFilterView)
        self.view.sendSubviewToBack(backgroundFilterView)
//        
//        let backgroundImgView = UIImageView(frame: CGRectMake(0, 20, (self.view.frame.height-20)*1.6, self.view.frame.height-20))
//        backgroundImgView.backgroundColor = UIColor.clearColor()
//        backgroundImgView.image = UIImage(named: "ylw")
//        self.view.addSubview(backgroundImgView)
//        self.view.sendSubviewToBack(backgroundImgView)
        leftCornerImgView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.height/4, self.view.frame.height/4))
        leftCornerImgView.image = UIImage(named: "plus")?.imageRotatedByDegrees(80, flip: false)
        leftCornerImgView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(leftCornerImgView);
        
        rightCornerImgView = UIImageView(frame: CGRectMake(self.view.frame.width - self.view.frame.height/4 - 13 , 0, self.view.frame.height/4, self.view.frame.height/4))
        rightCornerImgView.image = UIImage(named: "minus")?.imageRotatedByDegrees(15, flip: false)
        rightCornerImgView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(rightCornerImgView);
        
        leftCornerLowerImgView = UIImageView(frame: CGRectMake(0, self.view.frame.height - self.view.frame.height/5 - 13, self.view.frame.height/5, self.view.frame.height/5))
        leftCornerLowerImgView.image = UIImage(named: "mod")?.imageRotatedByDegrees(330, flip: false)
        leftCornerLowerImgView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(leftCornerLowerImgView);
        
        
        rightCornerLowerImgView = UIImageView(frame: CGRectMake(self.view.frame.width - self.view.frame.height/5 - 13, self.view.frame.height - self.view.frame.height/5 - 13, self.view.frame.height/5, self.view.frame.height/5))
        rightCornerLowerImgView.image = UIImage(named: "times")?.imageRotatedByDegrees(10, flip: false)
        rightCornerLowerImgView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(rightCornerLowerImgView);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}