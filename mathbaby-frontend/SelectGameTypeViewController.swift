//
//  SelectGameTypeViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/22/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

class SelectGameTypeViewController: GameTypeViewController {
    
    @IBAction func btnRightArrowTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GamePlayViewController))
    }
    
}
