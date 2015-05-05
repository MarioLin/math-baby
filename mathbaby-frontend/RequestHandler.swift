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
    
    // this function is only for debugging purpose
    #if DEBUG
    class func printServerStatus() {
        Alamofire.request(.GET, formatURL("serverStatus")).responseJSON {
            (request, response, data, error) in
            if error == nil {
                if let json=data as? Dictionary<String,Int> {
                    if let errCode = json["errCode"] {
                        println("Remote server is available")
                        return
                    }
                }
            }
            println("Remote server is unavailable")
            return
        }
    }
    #endif
    
    // retrieve the minimum score for getting into scoreboard
    class func updateMinimumScoreForScoreboard () {
        Alamofire.request(.GET, formatURL("fetchMinTopScore")).responseJSON {
            (request, response, data, error) in
            if error == nil {
                if let json=data as? Dictionary<String,AnyObject> {
                    if let entryScores = json["score"] as? Dictionary<Int, Int> {
                        for (gametype, score) in entryScores {
                            Singleton.sharedInstance.setMinimumScoreForGametype(gametype: gametype, score: score)
                        }
                    }
                }
            }
        }
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
    
    class private func formatURL(subURL: String) -> String {
        return "https://mathbaby-backend.herokuapp.com/" + subURL;
    }
}