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
        if Gametype.isValidGametype(Singleton.gametype) {
            self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GamePlayViewController))
        }
        
    }
    
}
