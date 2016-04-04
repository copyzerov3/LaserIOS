//
//  GameScene.swift
//  Laser Blast Battles
//
//  Created by Swift on 2016-03-27.
//  Copyright (c) 2016 Swift. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
    //UI Variables
    var pauseBtn: SKSpriteNode?;
    var powerBtn: SKSpriteNode?;
    var pauseLbl: SKLabelNode?;
    var powerLbl: SKLabelNode?;
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    //Powerup Variables
    var powerupTimer = 5.0;
    var timerDelay = 5.0;
    var powerup: SKSpriteNode?;
    var Timer:NSTimer = NSTimer();
    
    //Jarrett's temp score variables
    var score = 0;
    var highscore = 0;
    
    var HighscoreDefault = NSUserDefaults.standardUserDefaults();

    override func didMoveToView(view: SKView) //creates the scene
    {
        self.scaleMode = .AspectFill
        
        self.pauseBtn = createButton(CGPointMake(self.frame.midX, 25 + indent));
        self.powerBtn = createButton(CGPointMake(35, 35 + indent));
        self.pauseLbl = createLabel("Pause", fontSize: 25, position: CGPointMake(self.frame.midX, 25 + indent))
        self.powerLbl = createLabel("Power", fontSize: 25, position: CGPointMake(35, 35 + indent))
        
        self.addChild(pauseBtn!);
        self.addChild(powerBtn!);
        self.addChild(pauseLbl!);
        self.addChild(powerLbl!);
        
        Timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target:self, selector: "spawnPowerup", userInfo: nil, repeats: true);
        
        if (HighscoreDefault.valueForKey("Highscore") != nil)
        {
            highscore = HighscoreDefault.valueForKey("Highscore") as! NSInteger;
        }
    }
    
    func spawnPowerup() //spawns a powerup randomly on the game screen
    {
        //Doesnt randomize location yet.
        let newPowerup = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 50, height: 50));
        newPowerup.position = CGPointMake(self.frame.midX ,self.frame.midY);
        self.powerup = newPowerup;
        self.addChild(powerup!);
        //return newPowerup;
    }
    
    func createButton(position:CGPoint)->SKSpriteNode //function to create Buttons
    {
        let button = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50, height: 50));
        button.position = position;
        return button;
    }
    
    func createLabel(text: String, fontSize: CGFloat, position: CGPoint)->SKLabelNode //function to create Labels
    {
        let label = SKLabelNode(text: text);
        label.fontSize = fontSize;
        label.fontColor = UIColor.whiteColor();
        label.position = position;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center;
        //label.position.y -= fontSize/2;
        return label;
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) //Handles touches
    {
       /* Called when a touch begins */
        for touch in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node == self.pauseBtn!
            {
                let nextscene = GameScene(fileNamed: "GameScene")
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1)
                self.view?.presentScene(nextscene!, transition: transition)
            }
            if (node == self.powerBtn!)
            {
                //Jarrett's Temp Highscore Variables
                //var HighscoreDefault = NSUserDefaults.standardUserDefaults();
                highscore++;
                HighscoreDefault.setValue(highscore, forKey: "Highscore");
                HighscoreDefault.synchronize();
            }
            if (node == self.powerup! && self.powerup != nil)
            {
                //kills the powerup
                self.powerup?.removeFromParent();
            }

        }
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
}
