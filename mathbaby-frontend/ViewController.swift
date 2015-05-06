//
//  ViewController.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/3/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestHandler.printServerStatus()
        RequestHandler.fetchMinimumScoreForScoreboard()
        RequestHandler.fetchTop10(1)
        RequestHandler.fetchTop100(1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

