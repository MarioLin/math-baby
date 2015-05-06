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
        
    // retrieve the minimum score for getting into scoreboard
    class func fetchMinimumScoreForScoreboard () {
        sendRequest(.GET, suburl: "fetchMinTopScore") {
            (json) in
            if let entryScores = json["score"] as? Dictionary<String, Int> {
                for (gametype, score) in entryScores {
                    Singleton.sharedInstance.setMinimumScoreForGametype(gametype: gametype.toInt()!, score: score)
                }
            }
        }
    }
    
    class func fetchTop10 (gametype:Int) {
        sendRequest(.GET, suburl: "fetchTop10", parameters: ["level": gametype]) {
            (json) in
            if let topPlayers = json["topPlayers"] as? [[String:AnyObject]] {
                var topPlayersArray = [TopPlayer]()
                for topPlayerDict in topPlayers {
                    topPlayersArray.append(TopPlayer(dict: topPlayerDict))
                }
                Singleton.sharedInstance.setTopScoresForGametype(gametype: gametype, topPlayers: topPlayersArray)
            }
        }
    }
    
    class func fetchTop100 (gametype:Int) {
        sendRequest(.GET, suburl: "fetchTop100", parameters: ["level": gametype]) {
            (json) in
            if let topPlayers = json["topPlayers"] as? [[String:AnyObject]] {
                var topPlayersArray = [TopPlayer]()
                for topPlayerDict in topPlayers {
                    topPlayersArray.append(TopPlayer(dict: topPlayerDict))
                }
                Singleton.sharedInstance.setTopScoresForGametype(gametype: gametype, topPlayers: topPlayersArray)
            }
        }
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