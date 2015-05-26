//
//  NSNotificationCenterExtension.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/25/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
    
    class func postNotificationRetro(notificationName: String) {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: notificationName, object: nil))
    }
    
    class func addObserverRetro(obj: AnyObject, _ callback: Selector, _ notificationName: String) {
        NSNotificationCenter.defaultCenter().addObserver(obj, selector: callback, name: notificationName, object: nil)
    }
    
    class func removeObserverRetro(obj: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(obj)
    }
    
}
