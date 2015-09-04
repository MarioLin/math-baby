//
//  StringExtension.swift
//  mathbaby-frontend
//
//  Created by Tom Lai on 5/28/15.
//  Copyright (c) 2015 Tom Lai. All rights reserved.
//

import Foundation

extension String {

    subscript (i: Int) -> String {
        return String(self[advance(self.startIndex, i)] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = find(self, char) {
            return distance(self.startIndex, idx)
        }
        return nil
    }
}