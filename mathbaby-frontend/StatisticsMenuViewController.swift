//
//  File.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/22/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class StatisticsMenuViewController: BaseViewController {
    
    @IBOutlet weak var btnOptOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBtnOptOutText ()
        Singleton.updateUserStatistics()
    }
    
    @IBAction func btnStatisticsTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.UserStatisticsViewController))
    }
    
    @IBAction func btnOptOutTouchDown (AnyObject) {
        Singleton.statisticsOptOut = !Singleton.statisticsOptOut
        updateBtnOptOutText ()
    }
    
    @IBAction func btnBackTouchDown (AnyObject) {
        self.navigationController?.popViewControllerRetro()
    }
    
    private func updateBtnOptOutText () {
        if !Singleton.statisticsOptOut {
            btnOptOut.titleLabel?.font = UIFont.systemFontStandard
            btnOptOut.setTitleColor(UIColor.darkTextColor(), forState: UIControlState.Normal)
        } else {
            btnOptOut.titleLabel?.font = UIFont.systemFontStandardBold
            btnOptOut.setTitleColor(UIColor.palePinkColor(), forState: UIControlState.Normal)
        }
    }
    
}