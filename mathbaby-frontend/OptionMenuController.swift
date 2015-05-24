//
//  File.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/22/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class OptionMenuViewController: BaseViewController {
    
    @IBOutlet weak var btnOptOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBtnOptOutText ()
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
            btnOptOut.titleLabel?.font = MBFonts.systemFont
            btnOptOut.setTitleColor(UIColor.darkTextColor(), forState: UIControlState.Normal)
        } else {
            btnOptOut.titleLabel?.font = MBFonts.systemFontBold
            btnOptOut.setTitleColor(UIColor.palePinkColor(), forState: UIControlState.Normal)
        }
    }
    
}