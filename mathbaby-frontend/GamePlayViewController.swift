//
//  GamePlayViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/26/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

struct UIButtons {
    var buttons:[UIButton]!
}

class GamePlayViewController: BaseViewController {
    
    private var gameStarted = false
    var gameTime = 60.0
    var gameTimer:NSTimer?
    @IBOutlet weak var lbQuestion:UILabel!
    @IBOutlet weak var lbGametime:UILabel!
    @IBOutlet weak var lbScore:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerFire"), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        gameStarted = false
        updateGameTimerGraphics()
    }
    
    override func viewDidAppear(animated: Bool) {
        gameStarted = true
    }
    
    @IBAction func btnBackTouchDown (AnyObject) {
        self.navigationController?.popToRootViewControllerRetro()
    }
    
    @IBAction func DEBUG_btnProceedTouchDown (AnyObject) {
        self.navigationController?.pushViewControllerRetro(Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameResultViewController))
    }
    
    /* 
        call for each timer fire, and reduces remaining game time by 0.1s, updates game timer graphics
    */
    func timerFire () {
        gameTime -= 0.1
        updateGameTimerGraphics()
        if gameTime == 0 {
            endGame()
        }
    }
    
    func updateGameTimerGraphics() {
        lbGametime.text = String(format: "%.1f", gameTime)
    }
    
    func endGame () {
        gameTimer?.invalidate()
    }
    
}
