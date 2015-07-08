//
//  GameViewController.swift
//  SwiftGameOfLife
//
//  Created by Jayden Ma on 7/7/15.
//  Copyright (c) 2015 Metalworks. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var pauseButton: UIButton!
    
    var scene:GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pauseButton.layer.cornerRadius = 5;
        
        scene = GameScene(fileNamed:"GameScene")
        
        if (scene != nil) {
            // Configure the view.
            let skView = self.view as! SKView
            scene!.size = skView.bounds.size
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene!.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .Portrait
        } else {
            return .Portrait
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func pressedPaused(sender: UIButton) {
        if scene!.isGamePaused {
            scene!.setGamePause(false)
            pauseButton.setTitle("Pause", forState: UIControlState.Normal)
        } else {
            scene!.setGamePause(true)
            pauseButton.setTitle("Play", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func pressedZoomIn(sender: UIButton) {
        scene!.setZoom(2)
    }
    
    @IBAction func pressedZoomOut(sender: UIButton) {
        scene!.setZoom(0.5)
    }
}
