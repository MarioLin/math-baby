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
    override func viewDidLoad() {
        super.viewDidLoad()
        var scoreText = UILabel(frame: CGRectMake(0, self.view.frame.height/3-40, self.view.frame.width, 50))
        scoreText.text = "Your Score is:"
        scoreText.textAlignment = NSTextAlignment.Center
        scoreText.font = UIFont.systemFontStandard
        scoreText.font = scoreText.font.fontWithSize(30)
        self.view.addSubview(scoreText)
        var score = UILabel(frame:CGRectMake(0, self.view.frame.height/3, self.view.frame.width, self.view.frame.height/8))
        score.text = String(gameResult)
        score.textAlignment = NSTextAlignment.Center
        score.font = UIFont.systemFontStandard
        score.font = score.font.fontWithSize(self.view.frame.height/8)
        score.adjustsFontSizeToFitWidth = true
        self.view.addSubview(score)
    }

}