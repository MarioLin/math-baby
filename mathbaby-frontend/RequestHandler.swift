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
class RequestHandler {
    
    // call by RequestHandler.try()
    class func try() {
        Alamofire.request(.GET, "https://mathbaby-backend.herokuapp.com/serverStatus").responseJSON {
            (_, _, data, _) in
            if let json=data as? Dictionary<String,Int> {
                let errCode = json["errCode"]
                DLog("errCode is \(errCode!)");
            }
        }
    }
    
    // retrieve the minimum score for getting into scoreboard
    class func getMinimumScoreForScoreboard (#gametype: Int) -> Int {
        return 0
    }
    
    class func getTop10 () -> Bool {
        return true
    }
    
    class func getTop100 () -> Bool {
        return true
    }
    
    class func updatePersonalStatistic (#id: Int, score: Int, gametype: Int) -> Bool {
        return true
    }
    
    class func updateScoreboardWith (#name: String, id: Int, score: Int, gametype: Int) -> Bool {
        return true
    }
    
    private func sendRequest(requestType: Alamofire.Method, subURL: String, parameters: [String: AnyObject]? = nil) -> Bool {
        return true
    }
    
    private func formatURL(subURL: String) -> String {
        return "https://mathbaby-backend.herokuapp.com/" + subURL;
    }
}