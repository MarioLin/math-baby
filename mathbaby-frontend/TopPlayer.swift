//
//  TopPlayer.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/5/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

struct TopPlayer: Printable {
    let name: String
    let uid, score:Int
    
    init (dict:[String:AnyObject]) {
        name = dict["name"] as? String ?? "no name"
        uid = dict["uid"] as? Int ?? 0
        score = dict["score"] as? Int ?? 0
    }
    
    var description: String {
        return "TopPlayer(uid: \(uid), name: \(name), score: \(score))"
    }
}