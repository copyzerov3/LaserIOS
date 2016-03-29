//
//  HighScoresScene.swift
//  Laser Blast Battles
//
//  Created by iOS Outcasts on 2016-03-27.
//  Copyright © 2016 GBC. All rights reserved.
//

import SpriteKit

class HighScoresScene: SKScene
{
    //Labels
    var titleLbl: SKLabelNode? //Top Middle
    var titleTimeLbl: SKLabelNode? //Left
    var titleMarathonLbl: SKLabelNode? //Right
    var timeEasyLbl: SKLabelNode?
    var timeMedLbl: SKLabelNode?
    var timeHardLbl: SKLabelNode?
    var maraEasyLbl: SKLabelNode?
    var maraMedLbl: SKLabelNode?
    var maraHardLbl: SKLabelNode?
    
    //Buttons
    var backBtn: SKSpriteNode?; //Top Left
    var backLbl: SKLabelNode?;
    
    override func didMoveToView(view: SKView)
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("Laser Blast Battle High Scores", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 25));
        
        self.titleTimeLbl = createLabel("Time Trial", fontSize: 40,
            position: CGPointMake(self.frame.width/4 , self.frame.height/6*4));
        self.timeEasyLbl = createLabel("Easy: ", fontSize: 40,
            position: CGPointMake(self.frame.width/4 , self.frame.height/6*3));
        self.timeMedLbl = createLabel("Medium: ", fontSize: 40,
            position: CGPointMake(self.frame.width/4 , self.frame.height/6*2));
        self.timeHardLbl = createLabel("Hard: ", fontSize: 40,
            position: CGPointMake(self.frame.width/4 , self.frame.height/6*1));
        
        self.titleMarathonLbl = createLabel("Marathon", fontSize: 40,
            position: CGPointMake(self.frame.width/4*3 , self.frame.height/6*4));
        self.maraEasyLbl = createLabel("Easy: ", fontSize: 40,
            position: CGPointMake(self.frame.width/4*3 , self.frame.height/6*3));
        self.maraMedLbl = createLabel("Medium: ", fontSize: 40,
            position: CGPointMake(self.frame.width/4*3 , self.frame.height/6*2));
        self.maraHardLbl = createLabel("Hard: ", fontSize: 40,
            position: CGPointMake(self.frame.width/4*3 , self.frame.height/6*1));
        
        self.backBtn = createButton(CGPointMake(35, self.frame.height - 35));
        self.backLbl = createLabel("Back", fontSize: 25,
            position: CGPointMake(35, self.frame.height - 35));
        
        self.addChild(titleLbl!);
        self.addChild(titleTimeLbl!);
        self.addChild(timeEasyLbl!);
        self.addChild(timeMedLbl!);
        self.addChild(timeHardLbl!);
        self.addChild(titleMarathonLbl!);
        self.addChild(maraEasyLbl!);
        self.addChild(maraMedLbl!);
        self.addChild(maraHardLbl!);
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