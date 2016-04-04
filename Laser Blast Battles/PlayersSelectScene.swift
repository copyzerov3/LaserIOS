//
//  PlayersSelectScene.swift
//  Laser Blast Battles
//
//  Created by iOS Outcasts on 2016-03-27.
//  Copyright © 2016 GBC. All rights reserved.
//

import SpriteKit

class PlayersSelectScene: SKScene
{
    //Labels
    var titleLbl: SKLabelNode? //Top Middle
    //Buttons
    var backBtn: SKSpriteNode?; //Top Left
    var p1Btn: SKSpriteNode?; //Left
    var p2Btn: SKSpriteNode?; //Right
    var backLbl: SKLabelNode?;
    var p1Lbl: SKLabelNode?;
    var p2Lbl: SKLabelNode?;
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("How Many Players?", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.height - 25));
        
        self.p1Btn = createButton(CGPointMake(self.frame.width/3, self.frame.midY));
        self.p1Lbl = createLabel("1", fontSize: 25,
            position: CGPointMake(self.frame.width/3, self.frame.midY));
        
        self.p2Btn = createButton(CGPointMake(self.frame.width/3*2, self.frame.midY));
        self.p2Lbl = createLabel("2", fontSize: 25,
            position: CGPointMake(self.frame.width/3*2, self.frame.midY));
        
        self.backBtn = createButton(CGPointMake(35, self.frame.height - 35 - indent));
        self.backLbl = createLabel("Back", fontSize: 25,
            position: CGPointMake(35, self.frame.height - 35 - indent));
        
        self.addChild(titleLbl!);
        self.addChild(p1Btn!);
        self.addChild(p2Btn!);
        self.addChild(backBtn!);
        self.addChild(backLbl!);
        self.addChild(p1Lbl!);
        self.addChild(p2Lbl!);
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) //Handles Touches
    {
        for touch in touches
        {
            let location = touch.locationInNode(self);
            let node = self.nodeAtPoint(location);
            
            if node == self.backBtn!
            {
                let nextscene = MainMenuScene(fileNamed: "MainMenuScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
            if node == self.p1Btn!
            {
                let nextscene = SinglePlayerSettingsScene(fileNamed: "SinglePlayerSettingsScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
            if node == self.p2Btn!
            {
                let nextscene = MultiplayerSettingsScene(fileNamed: "MultiplayerSettingsScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
        }
    }
}