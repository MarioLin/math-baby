//
//  GameRecord.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/19/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import CoreData

@objc(GameRecord)
class GameRecord: NSManagedObject, Printable {

    @NSManaged var score: NSNumber
    @NSManaged var time: NSDate
    @NSManaged var type: NSNumber

    override var description: String {
        return "GameRecord(type: \(type), score: \(score))"
    }
}