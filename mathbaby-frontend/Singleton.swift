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
    
    // Sets up the default values for all menus
    class func setUpNSUserDefault() {
        if !userDefault.boolForKey(kUserDefault.defaultValueAlreadySet) {
            userDefault.setBool(true, forKey: kUserDefault.defaultValueAlreadySet)
            userDefault.setInteger(1, forKey: kUserDefault.gametype)
            userDefault.setBool(true, forKey: kUserDefault.surveyOptIn)
            userDefault.synchronize()
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
            return userDefault.integerForKey(kUserDefault.gametype)
        }
        set {
            userDefault.setInteger(newValue, forKey: kUserDefault.gametype)
            userDefault.synchronize()
        }
    }
    
    /* 
        Manages surveyOptIn default value in option menu, which decides whether the user record will be sent to backend
        NSUserDefaults is used to handle this value
        Value is retrieved from NSUserDefault in realtime when getter is called
        Value is stored into NSUserDefault and synchronized in realtime when setter is called
    */
    class var surveyOptIn: Bool {
        get {
            return userDefault.boolForKey(kUserDefault.surveyOptIn)
        }
        set {
            userDefault.setBool(newValue, forKey: kUserDefault.surveyOptIn)
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
        if let newRecord = NSEntityDescription.insertNewObjectForEntityForName("GameRecord", inManagedObjectContext: self.managedObjectContext) as? GameRecord {
            newRecord.time = NSDate()
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
    ==============================================================================
    =============================== DEBUGGING CODE ===============================
    ==============================================================================
    */
    #if DEBUG

    #endif
}