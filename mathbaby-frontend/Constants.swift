//
//  Constants.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/20/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct kUserDefault {
        static let defaultValueAlreadySet = "kUserDefaultDefaultValueAlreadySet"
        static let gametype = "kUserDefaultGametype"
        static let statisticsOptOut = "kUserDefaultSurveyOptIn"
    }
    
    struct kViewControllerIdentifier {
        static let mainMenuViewController = "MainMenuViewController"
        static let optionMenuViewController = "OptionMenuViewController"
        static let GameTypeViewController = "GameTypeViewController"
        static let CreditsViewController = "CreditsViewController"
    }
    
}

struct MBFonts {
    static let systemFontStandard = UIFont.systemFontOfSize(60)
    static let systemFontStandardBold = UIFont.boldSystemFontOfSize(60)
    static let systemFontLarge = UIFont.systemFontOfSize(75)
}