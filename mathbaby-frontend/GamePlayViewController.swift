//
//  GamePlayViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/26/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class GamePlayViewController: BaseViewController {
    
    @IBAction func btnBackTouchDown (AnyObject) {
        self.navigationController?.popToRootViewControllerRetro()
    }
    
    @IBAction func DEBUG_btnProceedTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameResultViewController))
    }
    
}
