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

    var gameTime = 60.0
    var gameTimer:NSTimer?
    var score = 0
    @IBOutlet weak var lbQuestion:UILabel!
    @IBOutlet weak var lbGametime:UILabel!
    @IBOutlet weak var lbScore:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(Singleton.gametype)
    }
    
    override func viewWillAppear(animated: Bool) {
        gameTime = Constants.defaultValues.game.gameTime
        score = Constants.defaultValues.game.score
        updateGameTimerGraphics()
    }
    
    override func viewDidAppear(animated: Bool) {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerFire"), userInfo: nil, repeats: true)
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
            gameTimer?.invalidate()
        }
    }
    
    func updateGameTimerGraphics() {
        lbGametime.text = String(format: "%.1f", gameTime)
        lbScore.text = String(format: "%d", score)
    }
    
    func endGame () {
        gameTimer?.invalidate()
        let vc = Singleton.instantiateViewControllerWithIdentifier(Constants.kViewControllerIdentifier.GameResultViewController) as! GameResultViewController
        vc.gameResult = score
        self.navigationController?.pushViewControllerRetro(vc)
    }
    
}
