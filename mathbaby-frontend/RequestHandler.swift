//
//  RequestHandler.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/3/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import Alamofire

class RequestHandler {
        
    class func updatePersonalStatistic (score: Int, gametype: Int) {
        sendRequest(.POST, suburl: "updateUserStatistics", parameters: ["score": score, "level": gametype]) {
            (json) in
        }
    }
    
    private func sendRequest(requestType: Alamofire.Method, subURL: String, parameters: [String: AnyObject]? = nil) -> Bool {
        return true
    }
    
    class private func formatURL(subURL: String) -> String {
        return "https://mathbaby-backend.herokuapp.com/" + subURL
    }
    
    // PARAMETERS:
    // method: .GET .POST
    // suburl: destination to send request
    // parameters: json parameters
    // callback: the callback function to be called on after receiving the json response
    class private func sendRequest(method: Alamofire.Method, suburl: String, parameters:[String:AnyObject]=[:], callback:([String:AnyObject])->()) {
        Alamofire.request(method, formatURL(suburl), parameters: parameters).responseJSON {
            (request, response, data, error) in
            if error == nil {
                // this cast should always succeed
                if let json=data as? [String:AnyObject] {
                    if json["errCode"] as! Int == 0 {
                        return callback(json)
                    }
                    return DLog("\(method.rawValue) \(suburl) -> json = \(json)")
                }
            }
            return DLog("\(method.rawValue) \(suburl) -> \(error!)")
        }
    }
    
    /*
    ==============================================================================
    =============================== DEBUGGING CODE ===============================
    ==============================================================================
    */
    #if DEBUG
    class func printServerStatus() {
        Alamofire.request(.GET, formatURL("serverStatus")).responseJSON {
            (request, response, data, error) in
            let remote = self.formatURL("")
            if error == nil {
                if let json=data as? Dictionary<String,Int> {
                    if let errCode = json["errCode"] {
                        return println("Server: \(remote) is available")
                    }
                }
            }
            return println("Server: \(remote) is unavailable")
        }
    }
    #endif
}