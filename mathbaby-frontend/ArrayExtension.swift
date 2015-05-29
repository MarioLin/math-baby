//
//  ArrayExtension.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/29/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}