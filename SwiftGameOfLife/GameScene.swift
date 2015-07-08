//
//  GameScene.swift
//  SwiftGameOfLife
//
//  Created by Jayden Ma on 7/7/15.
//  Copyright (c) 2015 Metalworks. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let pixelSize:CGFloat = 20.0
    let clockSpeed:Double = 0.5
    var nextTick:CFTimeInterval?
    var game:Game = Game()
    var isGamePaused:Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
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
                    print("Tick: \(currentTime)")
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
    
    func pressedPaused() {
        if isGamePaused {
            isGamePaused = false
        } else {
            isGamePaused = true
        }
    }
}
