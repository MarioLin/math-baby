//
//  GameResultViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/26/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class GameResultViewController: BaseViewController {
    
    var gameResult:Int = 0
    
    @IBAction func btnPlayAgainTouchDown (AnyObject) {
        self.navigationController?.popViewControllerReverseDirectionRetro()
    }
    
    @IBAction func btnBackToMainMenuTouchDown (AnyObject) {
        self.navigationController?.popToRootViewControllerRetro()
    }
    
}