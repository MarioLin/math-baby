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
        static let GamePlayViewController = "GamePlayViewController"
        static let GameResultViewController = "GameResultViewController"
    }
    
    struct defaultValues {
        
        struct game {
            static let gameTime = 12.0
            static let score = 0
            static let gametimePenaltyForWrongAnswer = -1.0
            static let gametimeRewardForCorrectAnswer = 0.5
            static let scoreRewardForCorrectAnswer = 1
        }
        
        struct userDefault {
            static let gametype = 1
            static let statisticsOptOut = false
        }
        
    }
    
}
