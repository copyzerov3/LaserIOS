//
//  SinglePlayerSettingsScene.swift
//  Laser Blast Battles
//
//  Created by iOS Outcasts on 2016-03-27.
//  Copyright © 2016 GBC. All rights reserved.
//

import SpriteKit

class SinglePlayerSettingsScene: SKScene
{
    //Labels
    var titleLbl: SKLabelNode? //Top Middle
    var diffLbl: SKLabelNode? //Middle
    var helpLbl: SKLabelNode? //Bottom Middle
    //Buttons
    var backBtn: SKSpriteNode?; //Top Left
    var timeTrialBtn: SKSpriteNode?; //Left
    var marathonBtn: SKSpriteNode?; //Right
    var easyBtn: SKSpriteNode?; //Left
    var mediumBtn: SKSpriteNode?; //middle
    var hardBtn: SKSpriteNode?; //Right
    var playBtn: SKSpriteNode?; //Top Right
    //Button Labels
    var backLbl: SKLabelNode?;
    var playLbl: SKLabelNode?;
    var timeTrialLbl: SKLabelNode?;
    var marathonLbl: SKLabelNode?;
    var easyLbl: SKLabelNode?;
    var mediumLbl: SKLabelNode?;
    var hardLbl: SKLabelNode?;
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("Choose your mode", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.height - 25));
        self.diffLbl = createLabel("Difficulty", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.midY));
        self.helpLbl = createLabel("Explains what the mode is that is selected", fontSize: 40,
            position: CGPointMake(self.frame.midX, 40));
        
        self.playBtn = createButton(CGPointMake(self.frame.width - 35, self.frame.height - 35 - indent));
        self.playLbl = createLabel("Play", fontSize: 25,
            position: CGPointMake(self.frame.width - 35, self.frame.height - 35 - indent));
        
        self.timeTrialBtn = createButton(CGPointMake(self.frame.width/3, self.frame.midY + 100));
        self.timeTrialLbl = createLabel("Time Trial", fontSize: 25,
            position: CGPointMake(self.frame.width/3, self.frame.midY + 100));
        self.marathonBtn = createButton(CGPointMake(self.frame.width/3*2, self.frame.midY + 100));
        self.marathonLbl = createLabel("Marathon", fontSize: 25,
            position: CGPointMake(self.frame.width/3*2, self.frame.midY + 100));
        
        self.easyBtn = createButton(CGPointMake(self.frame.width/6*2, self.frame.midY - 100));
        self.easyLbl = createLabel("Easy", fontSize: 25,
            position: CGPointMake(self.frame.width/6*2, self.frame.midY - 100));
        self.mediumBtn = createButton(CGPointMake(self.frame.width/6*3, self.frame.midY - 100));
        self.mediumLbl = createLabel("Medium", fontSize: 25,
            position: CGPointMake(self.frame.width/6*3, self.frame.midY - 100));
        self.hardBtn = createButton(CGPointMake(self.frame.width/6*4, self.frame.midY - 100));
        self.hardLbl = createLabel("Hard", fontSize: 25,
            position: CGPointMake(self.frame.width/6*4, self.frame.midY - 100));
        
        self.backBtn = createButton(CGPointMake(35, self.frame.height - 35 - indent));
        self.backLbl = createLabel("Back", fontSize: 25,
            position: CGPointMake(35, self.frame.height - 35 - indent));
        
        self.addChild(titleLbl!);
        self.addChild(diffLbl!);
        self.addChild(helpLbl!);
        self.addChild(timeTrialBtn!);
        self.addChild(marathonBtn!);
        self.addChild(easyBtn!);
        self.addChild(mediumBtn!);
        self.addChild(hardBtn!);
        self.addChild(playBtn!);
        self.addChild(backBtn!);
        self.addChild(playLbl!);
        self.addChild(backLbl!);
        self.addChild(timeTrialLbl!);
        self.addChild(marathonLbl!);
        self.addChild(easyLbl!);
        self.addChild(mediumLbl!);
        self.addChild(hardLbl!);
        
    }
    
    func createButton(position:CGPoint)->SKSpriteNode //Function to create Buttons
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) //Handles Touches
    {
        for touch in touches
        {
            let location = touch.locationInNode(self);
            let node = self.nodeAtPoint(location);
            
            if node == self.backBtn!
            {
                let nextscene = PlayersSelectScene(fileNamed: "PlayersSelectScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
            if node == self.playBtn!
            {
                let nextscene = GameScene(fileNamed: "GameScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
            if node == self.timeTrialBtn!
            {
                
            }
            if node == self.marathonBtn!
            {
                
            }
            if node == self.easyBtn!
            {
                
            }
            if node == self.mediumBtn!
            {
                
            }
            if node == self.hardBtn!
            {
                
            }
        }
    }
}