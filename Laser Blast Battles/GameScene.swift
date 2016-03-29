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
    var pauseBtn: SKSpriteNode?;
    var powerBtn: SKSpriteNode?;
    var pauseLbl: SKLabelNode?;
    var powerLbl: SKLabelNode?;
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        self.scaleMode = .AspectFill
        
        self.pauseBtn = createButton(CGPointMake(self.frame.midX, 25));
        self.powerBtn = createButton(CGPointMake(35, 35));
        self.pauseLbl = createLabel("Pause", fontSize: 25, position: CGPointMake(self.frame.midX, 25))
        self.powerLbl = createLabel("Power", fontSize: 25, position: CGPointMake(35, 35))
        
        self.addChild(pauseBtn!);
        self.addChild(powerBtn!);
        self.addChild(pauseLbl!);
        self.addChild(powerLbl!);
    }
    
    func createButton(position:CGPoint)->SKSpriteNode
    {
        let button = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50, height: 50));
        button.position = position;
        return button;
    }
    
    func createLabel(text: String, fontSize: CGFloat, position: CGPoint)->SKLabelNode
    {
        let label = SKLabelNode(text: text);
        label.fontSize = fontSize;
        label.fontColor = UIColor.whiteColor();
        label.position = position;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center;
        //label.position.y -= fontSize/2;
        return label;
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
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

        }
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
}
