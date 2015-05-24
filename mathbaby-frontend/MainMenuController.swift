//
//  ViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/3/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import UIKit

class MainMenuViewController: BaseViewController {
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnOption: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnPlayTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameTypeViewController))
    }
    
    @IBAction func btnOptionTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.optionMenuViewController))
    }
    
    @IBAction func btnCreditsTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.CreditsViewController))
    }

}

