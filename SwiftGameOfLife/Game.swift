//
//  Game.swift
//  SwiftGameOfLife
//
//  Created by Jayden Ma on 7/7/15.
//  Copyright © 2015 Metalworks. All rights reserved.
//

import Foundation

class Game {
    
    var aliveCells = Set<Cell>()
    
    func addCell(cell: Cell) {
        aliveCells.insert(cell)
    }
    
    // canonical to game of life, each update is a tick
    func tick() {
        // Here we need to update the state of the game according to how Game of Life rules work
//        1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
//        2. Any live cell with two or three live neighbours lives on to the next generation.
//        3. Any live cell with more than three live neighbours dies, as if by overcrowding.
//        4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        
        var cellsWithNeighbours = countCellsWithNeighbours()
        var newCells = Set<Cell>()
        
        // check the surviving cells in the next tick
        for cell in aliveCells {
            // removing here to prevent duplication of checking in next loop
            let neighbourCount:Int? = cellsWithNeighbours.removeValueForKey(cell)
            if  neighbourCount != nil && (neighbourCount >= 2 && neighbourCount <= 3) {
                newCells.insert(cell)
            }
        }
        
        // check for new cells in the next tick
        for (cell, neighbourCount) in cellsWithNeighbours {
            if neighbourCount == 3 {
                newCells.insert(cell)
            }
        }
        
        aliveCells = newCells
    }
    
    func countCellsWithNeighbours() -> Dictionary<Cell, Int> {
        var counterHash = initEmptyCounterHash()
        
        // What this does is add 1 to each neighbour of currently alive cell
        for cell in aliveCells{
            for neighbour in cell.neighbours(){
                if let currentCount = counterHash[neighbour]{
                    counterHash[neighbour] = currentCount + 1
                } else {
                    counterHash[neighbour] = 1
                }
            }
        }
        return counterHash
    }
    
    func initEmptyCounterHash() -> Dictionary<Cell, Int>{
        var counter = [Cell: Int]()
        for cell in aliveCells{
            counter[cell] = 0
        }
        return counter
    }
    
    func printCells(cells: [Int: Cell]) {
        for cell in cells {
            print(cell)
        }
    }
}
