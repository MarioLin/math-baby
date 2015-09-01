//
//  SelectGameTypeViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/22/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit
class SelectGameTypeViewController: GameTypeViewController {
    
    @IBAction func btnRightArrowTouchDown (AnyObject) {
        var vc = Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GamePlayViewController) as! GamePlayViewController
        vc.dualMode = self.dualModeSwitch.on
        if Gametype.isValidGametype(Singleton.gametype) {
            self.navigationController?.pushViewControllerRetro(vc)
        }
        
    }
    
}
