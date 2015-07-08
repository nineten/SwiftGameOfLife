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
    let clockSpeed:Double = 0.05
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
        let offset = 100
        
        // Gosper glider gun
        self.game.addCell(Cell(x: 10, y: 20 + offset))
        self.game.addCell(Cell(x: 11, y: 21 + offset))
        self.game.addCell(Cell(x: 10, y: 21 + offset))
        self.game.addCell(Cell(x: 11, y: 20 + offset))
        
        self.game.addCell(Cell(x: 23, y: 23 + offset))
        self.game.addCell(Cell(x: 22, y: 23 + offset))
        self.game.addCell(Cell(x: 21, y: 22 + offset))
        self.game.addCell(Cell(x: 20, y: 21 + offset))
        self.game.addCell(Cell(x: 20, y: 20 + offset))
        self.game.addCell(Cell(x: 20, y: 19 + offset))
        self.game.addCell(Cell(x: 21, y: 18 + offset))
        self.game.addCell(Cell(x: 22, y: 17 + offset))
        self.game.addCell(Cell(x: 23, y: 17 + offset))
        self.game.addCell(Cell(x: 25, y: 18 + offset))
        self.game.addCell(Cell(x: 26, y: 19 + offset))
        self.game.addCell(Cell(x: 26, y: 20 + offset))
        self.game.addCell(Cell(x: 27, y: 20 + offset))
        self.game.addCell(Cell(x: 24, y: 20 + offset))
        self.game.addCell(Cell(x: 26, y: 21 + offset))
        self.game.addCell(Cell(x: 25, y: 22 + offset))
        
        self.game.addCell(Cell(x: 30, y: 21 + offset))
        self.game.addCell(Cell(x: 30, y: 22 + offset))
        self.game.addCell(Cell(x: 30, y: 23 + offset))
        self.game.addCell(Cell(x: 31, y: 21 + offset))
        self.game.addCell(Cell(x: 31, y: 22 + offset))
        self.game.addCell(Cell(x: 31, y: 23 + offset))
        self.game.addCell(Cell(x: 32, y: 24 + offset))
        self.game.addCell(Cell(x: 32, y: 20 + offset))
        self.game.addCell(Cell(x: 34, y: 25 + offset))
        self.game.addCell(Cell(x: 34, y: 24 + offset))
        self.game.addCell(Cell(x: 34, y: 20 + offset))
        self.game.addCell(Cell(x: 34, y: 19 + offset))
        
        self.game.addCell(Cell(x: 44, y: 23 + offset))
        self.game.addCell(Cell(x: 44, y: 22 + offset))
        self.game.addCell(Cell(x: 45, y: 23 + offset))
        self.game.addCell(Cell(x: 45, y: 22 + offset))
        
        updateCells()
    }
}
