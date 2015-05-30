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
    
    @IBOutlet var btnRight: UIButton!
    @IBOutlet var btnCollection:[UIButton]!
    var btnToTick = [UIButton:UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in btnCollection {
            let tickLabel = UILabel(frame: CGRectMake(button.frame.size.width*0.8, button.frame.size.height*0.5, button.frame.size.width, button.frame.size.height))
            tickLabel.hidden = false
            tickLabel.text = "✔"
            btnToTick[button] = tickLabel
            button.addSubview(tickLabel)
        }
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
    
    func updateButtonState () {
        let gametype = Singleton.gametype
        for button in btnCollection {
            if gametype % button.tag == 0 {
                // type selected
                btnToTick[button]?.hidden = false
            } else {
                // type disselected
                btnToTick[button]?.hidden = true
            }

        }
        if Gametype.isValidGametype(gametype) {
            btnRight?.alpha = 1.0
        }
        else {
            btnRight?.alpha = 0.4
        }
    }
    
}
