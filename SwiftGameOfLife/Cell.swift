//
//  Cell.swift
//  SwiftGameOfLife
//
//  Created by Jayden Ma on 7/7/15.
//  Copyright © 2015 Metalworks. All rights reserved.
//

import Foundation

struct Cell : Hashable, Equatable, CustomStringConvertible {
    var x:Int = 0
    var y:Int = 0
    
    mutating func offsetBy(offset:(x:Int, y:Int)) {
        self = Cell(x: x + offset.x, y: y + offset.y)
    }
    
    var description: String {
        return "Cell: \(hashValue) -> (\(x), \(y))"
    }
    
    var hashValue: Int {
        return x * 10000 + y
    }
    
    // Get the surrounding cells around this cell
    func neighbours() -> Array<Cell>{
        var result:Array<Cell> = []
        for xModifier in (-1...1){
            for yModifier in (-1...1){
                if xModifier != 0 || yModifier != 0 {
                    result.append(Cell(x: self.x + xModifier, y: self.y + yModifier))
                }
            }
        }
        return result
    }
}

func ==(lhs: Cell, rhs: Cell) -> Bool{
    return lhs.x == rhs.x && lhs.y == rhs.y
}