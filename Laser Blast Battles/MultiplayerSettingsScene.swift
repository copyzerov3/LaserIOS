//
//  MultiplayerSettingsScene.swift
//  Laser Blast Battles
//
//  Created by iOS Outcasts on 2016-03-27.
//  Copyright © 2016 GBC. All rights reserved.
//

import SpriteKit

class MultiplayerSettingsScene: SKScene
{
    //Labels
    var titleLbl: SKLabelNode? //Top Middle
    var inst1Lbl: SKLabelNode? //below^
    var inst2Lbl: SKLabelNode? //below buttons below^
    var inst3Lbl: SKLabelNode? //below buttons below^
    var powerLbl: SKLabelNode?
    var timerLbl: SKLabelNode?
    var roundLbl: SKLabelNode?
    
    //Buttons
    var playBtn: SKSpriteNode?; //Top Right
    var backBtn: SKSpriteNode?; //Top Left
    //power ups
    var powerNoneBtn: SKSpriteNode?; //Left
    var powerLowBtn: SKSpriteNode?; //Right
    var powerMedBtn: SKSpriteNode?; //Left
    var powerHighBtn: SKSpriteNode?; //middle
    //time
    var timerNoneBtn: SKSpriteNode?; //Right
    var timer30Btn: SKSpriteNode?; //Right
    var timer60Btn: SKSpriteNode?; //Right
    var timer90Btn: SKSpriteNode?; //Right
    //rounds
    var round3Btn: SKSpriteNode?; //Right
    var round5Btn: SKSpriteNode?; //Right
    var round7Btn: SKSpriteNode?; //Right
    
    //Button Labels
    var backLbl: SKLabelNode?;
    var playLbl: SKLabelNode?;
    var powerNoneLbl: SKLabelNode?;
    var powerLowLbl: SKLabelNode?;
    var powerMedLbl: SKLabelNode?;
    var powerHighLbl: SKLabelNode?;
    var timerNoneLbl: SKLabelNode?;
    var timer30Lbl: SKLabelNode?;
    var timer60Lbl: SKLabelNode?;
    var timer90Lbl: SKLabelNode?;
    var round3Lbl: SKLabelNode?;
    var round5Lbl: SKLabelNode?;
    var round7Lbl: SKLabelNode?;
    
    
    override func didMoveToView(view: SKView)
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("Multiplayer Settings", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 25));
        self.inst1Lbl = createLabel("Amount of Power ups that show up during play", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.midY + 125));
        self.inst2Lbl = createLabel("The length of each round", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.midY + 25));
        self.inst3Lbl = createLabel("The amount of rounds", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.midY - 75));
        
        self.powerLbl = createLabel("Power Ups:", fontSize: 40,
            position: CGPointMake(self.frame.midX/7, self.frame.midY + 75));
        self.timerLbl = createLabel("Timer:", fontSize: 40,
            position: CGPointMake(self.frame.midX/7, self.frame.midY - 25));
        self.roundLbl = createLabel("Rounds:", fontSize: 40,
            position: CGPointMake(self.frame.midX/6, self.frame.midY - 125));
        
        self.playBtn = createButton(CGPointMake(self.frame.width - 35, self.frame.height - 35));
        self.playLbl = createLabel("Play", fontSize: 25,
            position: CGPointMake(self.frame.width - 35, self.frame.height - 35));
        self.backBtn = createButton(CGPointMake(35, self.frame.height - 35));
        self.backLbl = createLabel("Back", fontSize: 25,
            position: CGPointMake(35, self.frame.height - 35));
        
        self.powerNoneBtn = createButton(CGPointMake(self.frame.width/7*2, self.frame.midY + 75));
        self.powerNoneLbl = createLabel("None", fontSize: 25,
            position: CGPointMake(self.frame.width/7*2, self.frame.midY + 75));
        self.powerLowBtn = createButton(CGPointMake(self.frame.width/7*3, self.frame.midY + 75));
        self.powerLowLbl = createLabel("Low", fontSize: 25,
            position: CGPointMake(self.frame.width/7*3, self.frame.midY + 75));
        self.powerMedBtn = createButton(CGPointMake(self.frame.width/7*4, self.frame.midY + 75));
        self.powerMedLbl = createLabel("Medium", fontSize: 25,
            position: CGPointMake(self.frame.width/7*4, self.frame.midY + 75));
        self.powerHighBtn = createButton(CGPointMake(self.frame.width/7*5, self.frame.midY + 75));
        self.powerHighLbl = createLabel("High", fontSize: 25,
            position: CGPointMake(self.frame.width/7*5, self.frame.midY + 75));
        
        self.timerNoneBtn = createButton(CGPointMake(self.frame.width/7*2, self.frame.midY - 25));
        self.timerNoneLbl = createLabel("None", fontSize: 25,
            position: CGPointMake(self.frame.width/7*2, self.frame.midY - 25));
        self.timer30Btn = createButton(CGPointMake(self.frame.width/7*3, self.frame.midY - 25));
        self.timer30Lbl = createLabel("30", fontSize: 25,
            position: CGPointMake(self.frame.width/7*3, self.frame.midY - 25));
        self.timer60Btn = createButton(CGPointMake(self.frame.width/7*4, self.frame.midY - 25));
        self.timer60Lbl = createLabel("60", fontSize: 25,
            position: CGPointMake(self.frame.width/7*4, self.frame.midY - 25));
        self.timer90Btn = createButton(CGPointMake(self.frame.width/7*5, self.frame.midY - 25));
        self.timer90Lbl = createLabel("90", fontSize: 25,
            position: CGPointMake(self.frame.width/7*5, self.frame.midY - 25));
        
        self.round3Btn = createButton(CGPointMake(self.frame.width/6*2, self.frame.midY - 125));
        self.round3Lbl = createLabel("3", fontSize: 25,
            position: CGPointMake(self.frame.width/6*2, self.frame.midY - 125));
        self.round5Btn = createButton(CGPointMake(self.frame.width/6*3, self.frame.midY - 125));
        self.round5Lbl = createLabel("5", fontSize: 25,
            position: CGPointMake(self.frame.width/6*3, self.frame.midY - 125));
        self.round7Btn = createButton(CGPointMake(self.frame.width/6*4, self.frame.midY - 125));
        self.round7Lbl = createLabel("7", fontSize: 25,
            position: CGPointMake(self.frame.width/6*4, self.frame.midY - 125));
        
        self.addChild(titleLbl!);
        self.addChild(inst1Lbl!);
        self.addChild(inst2Lbl!);
        self.addChild(inst3Lbl!);
        self.addChild(powerLbl!);
        self.addChild(timerLbl!);
        self.addChild(roundLbl!);
        
        self.addChild(powerNoneBtn!);
        self.addChild(powerLowBtn!);
        self.addChild(powerMedBtn!);
        self.addChild(powerHighBtn!);
        
        self.addChild(timerNoneBtn!);
        self.addChild(timer30Btn!);
        self.addChild(timer60Btn!);
        self.addChild(timer90Btn!);
        
        self.addChild(round3Btn!);
        self.addChild(round5Btn!);
        self.addChild(round7Btn!);
        
        self.addChild(playBtn!);
        self.addChild(backBtn!);
        
        self.addChild(playLbl!);
        self.addChild(backLbl!);
        self.addChild(powerNoneLbl!);
        self.addChild(powerLowLbl!);
        self.addChild(powerMedLbl!);
        self.addChild(powerHighLbl!);
        self.addChild(timerNoneLbl!);
        self.addChild(timer30Lbl!);
        self.addChild(timer60Lbl!);
        self.addChild(timer90Lbl!);
        self.addChild(round3Lbl!);
        self.addChild(round5Lbl!);
        self.addChild(round7Lbl!);
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
            if node == self.playBtn!
            {
                
            }
            if node == self.powerNoneBtn!
            {
                
            }
            if node == self.powerLowBtn!
            {
                
            }
            if node == self.powerMedBtn!
            {
                
            }
            if node == self.powerHighBtn!
            {
                
            }
            if node == self.timerNoneBtn!
            {
                
            }
            if node == self.timer30Btn!
            {
                
            }
            if node == self.timer60Btn!
            {
                
            }
            if node == self.timer90Btn!
            {
                
            }
            if node == self.round3Btn!
            {
                
            }
            if node == self.round5Btn!
            {
                
            }
            if node == self.round7Btn!
            {
                
            }
        }
    }
}