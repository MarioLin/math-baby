//
//  RequestHandler.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/3/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

import Alamofire

// sample code to check server status of backend
public func try() {
    Alamofire.request(.GET, "https://mathbaby-backend.herokuapp.com/serverStatus").responseJSON {
        (_, _, data, _) in
        if let json=data as? Dictionary<String,Int> {
            let errCode = json["errCode"]
            DLog("errCode is \(errCode!)");
        }
    }
}