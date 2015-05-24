//
//  GameViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/22/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class GameTypeViewController: BaseViewController {
    
    @IBOutlet var btnCollection:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonState ()
    }
    
    @IBAction func btnBackTouchDown (AnyObject) {
        self.navigationController?.popViewControllerRetro()
    }
    
    @IBAction func btnOperationClicked (sender: UIButton) {
        let gametype = Singleton.gametype
        if gametype % sender.tag == 0 {
            Singleton.gametype = gametype / sender.tag
        } else {
            Singleton.gametype = gametype * sender.tag
        }
        updateButtonState()
    }
    
    private func updateButtonState () {
        for button in btnCollection {
            let gametype = Singleton.gametype
            if gametype % button.tag == 0 {
                button.titleLabel?.font = MBFonts.systemFontLarge
            } else {
                button.titleLabel?.font = MBFonts.systemFontStandard
            }
        }
    }
    
}
