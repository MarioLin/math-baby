//
//  CreditsViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/22/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

class CreditsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnBackTouchDown (AnyObject) {
        self.navigationController?.popViewControllerRetro()
    }
    
}
