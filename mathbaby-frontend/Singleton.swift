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
    
    /*
        Insert a new game record into permanent storage
    
        score: the score of that game
        type: the type of game identified
    
        return GameRecord on success, nil on failure
    */
    class func storeGameRecord(#score: Int, type: Int) -> GameRecord? {
        if let newRecord = NSEntityDescription.insertNewObjectForEntityForName("GameRecord", inManagedObjectContext: self.managedObjectContext) as? GameRecord {
            newRecord.time = NSDate()
            newRecord.score = score
            newRecord.type = type
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