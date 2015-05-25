//
//  Constants.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/20/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

struct Constants {
    
    struct kNSNotification {
        static let statisticsUpdate = "kNSNotificationStatisticsUpdate"
    }
    
    struct kUserDefault {
        static let defaultValueAlreadySet = "kUserDefaultDefaultValueAlreadySet"
        static let gametype = "kUserDefaultGametype"
        static let statisticsOptOut = "kUserDefaultSurveyOptIn"
    }
    
    struct kViewControllerIdentifier {
        static let mainMenuViewController = "MainMenuViewController"
        static let StatisticsMenuViewController = "StatisticsMenuViewController"
        static let SelectGameTypeViewController = "SelectGameTypeViewController"
        static let CreditsViewController = "CreditsViewController"
        static let UserStatisticsViewController = "UserStatisticsViewController"
    }
    
}
