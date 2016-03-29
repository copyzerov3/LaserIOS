//
//  CreditsScene.swift
//  Laser Blast Battles
//
//  Created by iOS Outcasts on 2016-03-27.
//  Copyright © 2016 GBC. All rights reserved.
//

import SpriteKit

class CreditsScene: SKScene
{
    //Credits
    var titleLbl: SKLabelNode? //Top Middle
    var dougsLbl: SKLabelNode? //below ^
    var jarrettsLbl: SKLabelNode? //below ^
    var assetsLbl: SKLabelNode? //below ^
    
    //Buttons
    var backBtn: SKSpriteNode?; //Top Left
    var backLbl: SKLabelNode?;
    
    override func didMoveToView(view: SKView)
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("Laser Blast Battle Credits", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 25));
        self.dougsLbl = createLabel("What ever Doug does", fontSize: 30,
            position: CGPointMake(self.frame.midX, self.frame.midY + 75));
        self.jarrettsLbl = createLabel("What ever Jarrett does", fontSize: 30,
            position: CGPointMake(self.frame.midX, self.frame.midY));
        self.assetsLbl = createLabel("Asset References", fontSize: 30,
            position: CGPointMake(self.frame.midX, self.frame.midY - 75));
        
        self.backBtn = createButton(CGPointMake(35, self.frame.height - 35));
        self.backLbl = createLabel("Back", fontSize: 25,
            position: CGPointMake(35, self.frame.height - 35));
        
        self.addChild(titleLbl!);
        self.addChild(dougsLbl!);
        self.addChild(jarrettsLbl!);
        self.addChild(assetsLbl!);
        self.addChild(backBtn!);
        self.addChild(backLbl!);
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
        for touch in touches
        {
            let location = touch.locationInNode(self);
            let node = self.nodeAtPoint(location);
            
            if node == self.backBtn!
            {
                let nextscene = GameScene(fileNamed: "MainMenuScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
        }
    }
}