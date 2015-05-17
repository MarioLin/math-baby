//
//  Singleton.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/5/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

enum Gametype : Int {
    case kGTAdd = 3
    case kGTSub = 5
    case kGTMul = 7
    case kGTDiv = 11
    
    static func isValidGametype (var gametype:Int) -> Bool {
        if gametype == 1 {
            return false
        }
        for key in [Gametype.kGTAdd, Gametype.kGTSub, Gametype.kGTMul, Gametype.kGTDiv] {
            if gametype % key.rawValue == 0 {
                gametype = gametype / key.rawValue
            }
        }
        return gametype == 1
    }
}



class Singleton {
    
    static let sharedInstance = Singleton()
    
    init() {
        if let id = KeychainHandler.load(KeychainKeys.kUserId)?.toInt() {
            uid = id
        }
        if let name = KeychainHandler.load(KeychainKeys.kUserId) {
            _username = name
        }
    }
    
    var uid = -1
    private var _username = "my name"
    private var _minimumScoreForGametype = [Int: Int] ()
    private var _topScoresForGametype = [Int: [TopPlayer]] ()
    
    // sets the corresponding minimum score for game type
    // only sets when game type is a valid value
    func setMinimumScoreForGametype(#gametype:Int, score:Int) {
        if Gametype.isValidGametype(gametype) {
            _minimumScoreForGametype[gametype] = score
        }
    }
    
    // returns corresponding minimum score to enter scoreboard
    // if invalid gametype is passed as parameters, Int.max is returned
    func getMinimumScoreForGametype(gametype:Int) -> Int {
        if Gametype.isValidGametype(gametype) {
            return _minimumScoreForGametype[gametype] ?? 0
        } else {
            // this line should not be reached
            DLog("Invalid gametype: \(gametype)")
            return Int.max
        }
    }
    
    // sets the corresponding minimum score for game type
    // only sets when game type is a valid value
    func setTopScoresForGametype(#gametype:Int, topPlayers:[TopPlayer]) {
        if Gametype.isValidGametype(gametype) {
            _topScoresForGametype[gametype] = topPlayers
        }
    }
    
    // returns corresponding minimum score to enter scoreboard
    // if invalid gametype is passed as parameters, Int.max is returned
    func getTopScoresForGametype(gametype:Int) -> [TopPlayer] {
        return _topScoresForGametype[gametype] ?? []
    }
    
    
    class func store () {
        KeychainHandler.store(KeychainKeys.kUserId, value: String(Singleton.sharedInstance.uid))
        KeychainHandler.store(KeychainKeys.kUsername, value: Singleton.sharedInstance._username)
    }
    
    /*
    ==============================================================================
    =============================== DEBUGGING CODE ===============================
    ==============================================================================
    */
    #if DEBUG
    class func printMinimumScoreDictionary() {
        println("minimum entry score: \(Singleton.sharedInstance._minimumScoreForGametype)")
    }
    #endif
}