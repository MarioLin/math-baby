//
//  NumberExtension.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/28/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

extension Double {
    
    func formatString(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
}