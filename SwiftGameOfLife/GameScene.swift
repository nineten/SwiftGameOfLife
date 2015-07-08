//
//  GameScene.swift
//  SwiftGameOfLife
//
//  Created by Jayden Ma on 7/7/15.
//  Copyright (c) 2015 Metalworks. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var pixelSize:CGFloat = 20.0
    let clockSpeed:Double = 0.015
    var nextTick:CFTimeInterval?
    var game:Game = Game()
    var isGamePaused:Bool = true
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor.whiteColor()
        addExamples()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch began */
        processTouches(touches);
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch move */
        processTouches(touches);
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // allow pausing of game
        if !isGamePaused {
            
            // check if next tick is initialised yet
            if nextTick != nil {
                let timeInterval = currentTime - nextTick!
                if timeInterval > clockSpeed {
                    game.tick()
                    updateCells()
                    
                    nextTick = currentTime;
//                    print("Tick: \(currentTime)")
                }
            } else {
                // initialise the nextTick timer
                nextTick = currentTime
            }
        }
    }
    
    func processTouches(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let cell = convertPixelsToCell(location)
            game.addCell(cell)
            createCell(cell);
        }
    }
    
    func updateCells() {
        self.removeAllChildren()
        for cell in game.aliveCells {
            print(cell)
            createCell(cell)
        }
    }
    
    func createCell(cell: Cell) -> SKSpriteNode{
        let sprite = SKSpriteNode()
        sprite.color = UIColor.blackColor()
        sprite.size = CGSizeMake(pixelSize, pixelSize)
        sprite.position = convertCellToPixels(cell)
        self.addChild(sprite)
        return sprite
    }
    
    func convertPixelsToCell(pixel: CGPoint) -> Cell{
        return Cell(x: Int(pixel.x / pixelSize), y: Int(pixel.y / pixelSize))
    }
    
    func convertCellToPixels(cell:Cell) -> CGPoint{
        return CGPointMake(CGFloat(cell.x) * pixelSize, CGFloat(cell.y) * pixelSize)
    }
    
    func setGamePause(state: Bool) {
        isGamePaused = state
    }
    
    func setZoom(zoom: Float) {
        pixelSize = pixelSize / CGFloat(zoom)
        updateCells()
    }
    
    func addExamples(){
//        addGosperGliderGun((100,100))
//        addGosperGliderGun((60,140))
//        addGosperGliderGun((20,180))
        
        addMaxFiller((200,500))
        
        updateCells()
    }
    
    func addGosperGliderGun(offset:(x:Int, y:Int)) {
        let cells = [
        (0,3),(0,4),(1,3),(1,4),
        (10,2),(10,3),(10,4),(11,1),(11,5),(12,0),(12,6),(13,0),(13,6),(14,3),(15,1),(15,5),(16,2),(16,3),(16,4),(17,3),
        (20,4),(20,5),(20,6),(21,4),(21,5),(21,6),(22,3),(22,7),(24,2),(24,3),(24,7),(24,8),
        (34,5),(34,6),(35,5),(35,6)]
        
        addCellsWithOffset(cells, offset: offset)
    }
    
    func addMaxFiller(offset:(x:Int, y:Int)) {
        let cells = [
        (8,0),
        (7,1),(8,1),(9,1),
        (6,2),(7,2),(12,2),(13,2),(14,2),
        (4,3),(5,3),(7,3),(10,3),(11,3),(12,3),(15,3),
        (5,4),(7,4),(10,4),(12,4),(16,4),
        (2,5),(3,5),(5,5),(7,5),(9,5),(11,5),(16,5),
        (2,6),(3,6),(7,6),(9,6),(14,6),
        (2,7),(3,7),(4,7),(6,7),(10,7),(15,7),(17,7),(23,7),(24,7),(25,7),(26,7),
        (1,8),(2,8),(12,8),(13,8),(15,8),(16,8),(17,8),(19,8),(21,8),(22,8),(26,8),
        (13,9),(19,9),(20,9),(26,9),
        (10,10),(11,10),(13,10),(16,10),(19,10),(21,10),(22,10),(25,10),
        (0,11),(1,11),(2,11),(3,11),(9,11),(11,11),(13,11),(15,11),(17,11),(19,11),
        (0,12),(4,12),(5,12),(7,12),(9,12),(10,12),(13,12),(16,12),(19,12),(21,12),(22,12),(25,12),
        (0,13),(6,13),(7,13),(11,13),(13,13),(15,13),(19,13),(20,13),(26,13),
        (1,14),(4,14),(5,14),(7,14),(10,14),(13,14),(16,14),(17,14),(19,14),(21,14),(22,14),(26,14),
        (7,15),(9,15),(11,15),(13,15),(15,15),(17,15),(23,15),(24,15),(25,15),(26,15),
        (1,16),(4,16),(5,16),(7,16),(10,16),(13,16),(15,16),(16,16),
        (0,17),(6,17),(7,17),(13,17),
        (0,18),(4,18),(5,18),(7,18),(9,18),(10,18),(11,18),(13,18),(14,18),(24,18),(25,18),
        (0,19),(1,19),(2,19),(3,19),(9,19),(11,19),(16,19),(20,19),(22,19),(23,19),(24,19),
        (12,20),(17,20),(19,20),(23,20),(24,20),
        (10,21),(15,21),(17,21),(19,21),(21,21),(23,21),(24,21),
        (10,22),(14,22),(16,22),(19,22),(21,22),
        (11,23),(14,23),(15,23),(16,23),(19,23),(21,23),(22,23),
        (12,24),(13,24),(14,24),(19,24),(20,24),
        (17,25),(18,25),(19,25),
        (18,26)
        ]
        
        addCellsWithOffset(cells, offset: offset)
    }
    
    func addCellsWithOffset(cellPositions: [(Int,Int)], offset: (x:Int, y:Int)) {
        for cellPos in cellPositions {
            addCellAtPositionWithOffset(cellPos, offset: offset)
        }
    }
    
    func addCellAtPositionWithOffset(pos:(x:Int, y:Int), offset:(x:Int, y:Int)) {
        game.addCellAtOffset(Cell(x: pos.x, y: pos.y), offset: offset)
    }

}
