//
//  KeychainHandler.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/3/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import UIKit
import Security
import Locksmith

public enum KeychainKeys: String {
    case kUserId = "keyUserId"
    case kUsername = "keyUserName"
}

public class KeychainHandler {
    
    // PARAMETERS:
    // key: KeychainKeys
    // value: String
    // RETURN VALUE: true on success, false on failure
    class func store (key: KeychainKeys, value: String) -> Bool {
        if let error = Locksmith.saveData(["value": value], forUserAccount: key.rawValue) {
            if let error = Locksmith.updateData([key.rawValue: value], forUserAccount: key.rawValue) {
                return false
            }
        }
        return true
    }
    
    // PARAMETERS:
    // key: KeychainKeys
    // RETURN VALUE: stored string on success, nil on failure
    // EXAMPLE:
    // if let username = KeychainHandler.load(KeychainKeys.kUsername) {
    //     value retrieved and stored to result
    // } else
    //     load failed
    // }
    class func load (key: KeychainKeys) -> String? {
        let (dictionary, error) = Locksmith.loadDataForUserAccount(key.rawValue)
        return dictionary?[key.rawValue] as? String
    }
    
    class func clearData () {
        Locksmith.deleteDataForUserAccount(KeychainKeys.kUserId.rawValue)
        Locksmith.deleteDataForUserAccount(KeychainKeys.kUsername.rawValue)
    }
}