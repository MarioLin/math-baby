//
//  Singleton.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/5/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
    
    static private let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    static private let userDefault = NSUserDefaults.standardUserDefaults()
    static private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    static private var gameTypeTogameRecords = [Int:GameRecord]()
    static private var gametypeToPercentile = [Int:Double]()
    
    // Sets up the default values for all menus
    class func setUp() {
        if !userDefault.boolForKey(Constants.kUserDefault.defaultValueAlreadySet) {
            userDefault.setBool(true, forKey: Constants.kUserDefault.defaultValueAlreadySet)
            userDefault.setInteger(1, forKey: Constants.kUserDefault.gametype)
            userDefault.setBool(false, forKey: Constants.kUserDefault.statisticsOptOut)
            userDefault.synchronize()
        }
        for gameRecord in loadGameRecords() {
            gameTypeTogameRecords[Int(gameRecord.gametype)] = gameRecord
        }
    }
    
    /*
        Manages gametype default value in option menu
        NSUserDefaults is used to handle this value
        Value is retrieved from NSUserDefault in realtime when getter is called
        Value is stored into NSUserDefault and synchronized in realtime when setter is called
    */
    class var gametype: Int {
        get {
            return userDefault.integerForKey(Constants.kUserDefault.gametype)
        }
        set {
            userDefault.setInteger(newValue, forKey: Constants.kUserDefault.gametype)
            userDefault.synchronize()
        }
    }
    
    /* 
        Manages surveyOptIn default value in option menu, which decides whether the user record will be sent to backend
        NSUserDefaults is used to handle this value
        Value is retrieved from NSUserDefault in realtime when getter is called
        Value is stored into NSUserDefault and synchronized in realtime when setter is called
    */
    class var statisticsOptOut: Bool {
        get {
            return userDefault.boolForKey(Constants.kUserDefault.statisticsOptOut)
        }
        set {
            userDefault.setBool(newValue, forKey: Constants.kUserDefault.statisticsOptOut)
            userDefault.synchronize()
        }
    }
    
    /*
        Insert a new game record into permanent storage
    
        score: the score of that game
        type: the type of game identified
    
        return GameRecord on success, nil on failure
    */
    class func storeGameRecord(#score: Int, gametype: Int) -> GameRecord? {
        if let gameRecord = gameTypeTogameRecords[gametype] {
            gameRecord.score = max(score, Int(gameRecord.score))
            return gameRecord
        }
        if let newRecord = NSEntityDescription.insertNewObjectForEntityForName("GameRecord", inManagedObjectContext: self.managedObjectContext) as? GameRecord {
            newRecord.score = score
            newRecord.gametype = gametype
            return newRecord
        }
        return nil
    }
    
    /*
        return all game records as an array
    */
    class func loadGameRecords() -> [GameRecord] {
        return managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "GameRecord"), error: nil) as! [GameRecord]
    }
    
    /*
        return a corresponding view controller as indicated by storyboardID
    
        error will be raised by call to instantiateViewControllerWithIdentifier 
        if no view controller in storyboard contains such storyboard id
    */
    class func instantiateViewControllerWithIdentifier(storyboardID: String) -> BaseViewController {
        return storyboard.instantiateViewControllerWithIdentifier(storyboardID) as! BaseViewController
    }
    
    /*
        update all user statistics in gametypeToPercentile with data from backend server
        after each update done, Constants.kNSNotification.statisticsUpdate is posted in notification center
    */
    class func updateUserStatistics () {
        for (gametype, gameRecord) in gameTypeTogameRecords {
            self.gametypeToPercentile[gametype] = nil
            RequestHandler.sendGetRequest(suburl: "fetchUserRankingForGames", parameters: ["level": gametype, "score": gameRecord.score]) {
                (json) in
                if let percentile = json[String(gametype)] as? Double {
                    self.gametypeToPercentile[gametype] = percentile
                    NSNotificationCenter.postNotificationRetro(Constants.kNSNotification.statisticsUpdate)
                }
            }
        }
    }
    
    /*
        return true if user statistics for game type is available, false otherwise
    */
    class func isUserStatisticsAvailableForGametype (gametype: Int) -> Bool {
        return gameTypeTogameRecords[gametype] != nil
    }
    
    
    /* 
        return the percentile of user for the requested gametype
    
        if the data is not available yet, nil will be returned
        caller should listen for Constants.kNSNotification.statisticsUpdate to wait for update to user statistics
    */
    class func getUserStatisticsForGametype (gametype: Int) -> Double? {
        return gametypeToPercentile[gametype]
    }
    
    // return user percentile for requested gametype
    // nil is return when data is not available yet
    class func getPercentileForGametype(gametype:Int) -> Double? {
        return gametypeToPercentile[gametype]
    }
}