//
//  UserStatisticsViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/24/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

class UserStatisticsViewController: GameTypeViewController {
    
    @IBOutlet weak var lbStatistics:UILabel!
    
    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStatisticLabel ()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("timerFire"), userInfo: nil, repeats: true)
        NSNotificationCenter.addObserverRetro(self, Selector("updateStatisticLabel"), Constants.kNSNotification.statisticsUpdate)
    }
    
    @IBAction override func btnOperationClicked (sender: UIButton) {
        super.btnOperationClicked(sender)
        updateStatisticLabel ()
    }
    
    func updateStatisticLabel () {
        let gametype = Singleton.gametype
        if gametype == 1 {
            lbStatistics.text = ""
        } else if Singleton.isUserStatisticsAvailableForGametype(gametype) {
            if let percentile = Singleton.getPercentileForGametype(gametype) {
                lbStatistics.text = "\(percentile)"
            } else {
                lbStatistics.text = "loading."
            }
        } else {
            lbStatistics.text = "unavailable"
        }
    }
    
    func timerFire() {
        if lbStatistics.text == "loading." {
            lbStatistics.text = "loading.."
        } else if lbStatistics.text == "loading.." {
            lbStatistics.text = "loading..."
        } else if lbStatistics.text == "loading..." {
            lbStatistics.text = "loading."
        }
    }
    
    deinit {
        NSNotificationCenter.removeObserverRetro(self)
    }
    
}
