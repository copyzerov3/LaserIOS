//
//  MainMenuScene.swift
//  Laser Blast Battles
//
//  Created by iOS Outcasts on 2016-03-27.
//  Copyright © 2016 GBC. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene
{
    //Main Menu
    var titleLbl: SKLabelNode? //Top Middle
    //Main Buttons
    var playBtn: SKSpriteNode?; //Middle
    var highScoreBtn: SKSpriteNode?; //Below^
    var creditsBtn: SKSpriteNode?; //Below^
    //Settings Buttons
    var musicBtn: SKSpriteNode?; //Bottom Left
    var soundEffectsBtn: SKSpriteNode?; //Right of^
    var vibrationBtn: SKSpriteNode?; //Right of^
    //Labels for Buttons
    var playLbl: SKLabelNode?
    var highScoreLbl: SKLabelNode?
    var highScoreLbl2: SKLabelNode?
    var creditsLbl: SKLabelNode?
    var musicLbl: SKLabelNode?
    var soundEffectsLbl: SKLabelNode?
    var soundEffectsLbl2: SKLabelNode?
    var vibrationLbl: SKLabelNode?
    
    var TestButton:Button?;
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        self.titleLbl = createLabel("Laser Blast Battles!", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 25));
        
        self.playBtn = createButton(CGPointMake(self.frame.midX, self.frame.midY));
        self.highScoreBtn = createButton(CGPointMake(self.frame.midX, self.frame.midY - 75));
        self.creditsBtn = createButton(CGPointMake(self.frame.midX, self.frame.midY - 150));
        self.musicBtn = createButton(CGPointMake(35, 35 + indent));
        self.soundEffectsBtn = createButton(CGPointMake(35 + 75, 35 + indent));
        self.vibrationBtn = createButton(CGPointMake(35 + 150, 35 + indent));
        
        self.playLbl = createLabel("Play", fontSize: 25, position: CGPointMake(self.frame.midX, self.frame.midY))
        self.highScoreLbl = createLabel("High", fontSize: 25, position: CGPointMake(self.frame.midX, self.frame.midY - 75))
        self.highScoreLbl2 = createLabel("Scores", fontSize: 25, position: CGPointMake(self.frame.midX, self.frame.midY - 75))
        self.creditsLbl = createLabel("Credits", fontSize: 25, position: CGPointMake(self.frame.midX, self.frame.midY - 150))
        self.musicLbl = createLabel("Music", fontSize: 25, position: CGPointMake(35, 35 + indent))
        self.soundEffectsLbl = createLabel("Sounds", fontSize: 25, position: CGPointMake(35 + 75, 35 + indent))
        self.soundEffectsLbl2 = createLabel("Effects", fontSize: 25, position: CGPointMake(35 + 75, 35 + indent))
        self.vibrationLbl = createLabel("Vibration", fontSize: 25, position: CGPointMake(35 + 150, 35 + indent))
        
        self.addChild(titleLbl!);
        self.addChild(playBtn!);
        self.addChild(highScoreBtn!);
        self.addChild(creditsBtn!);
        self.addChild(musicBtn!);
        self.addChild(soundEffectsBtn!);
        self.addChild(vibrationBtn!);
        self.addChild(playLbl!);
        self.addChild(highScoreLbl!);
        self.addChild(creditsLbl!);
        self.addChild(musicLbl!);
        self.addChild(soundEffectsLbl!);
        self.addChild(vibrationLbl!);
        
        
        TestButton = Button(text: "Test");
        TestButton?.SetPosition(CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)));
        TestButton?.onPressCode = {self.view?.presentScene(PlayersSelectScene(fileNamed:"PlayersSelectScene")!,transition:SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 1));}
        addChild(TestButton!);
    }
    
    func createButton(position:CGPoint)->SKSpriteNode //function to create Buttons
    {
        let button = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50, height: 50));
        //button.anchorPoint = CGPointMake(0, 0);
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
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        TestButton?.touchesMoved(touches, withEvent: event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        TestButton?.touchesEnded(touches,withEvent:event);
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) //Handles Touches
    {
        for touch in touches
        {
            let location = touch.locationInNode(self);
            let node = self.nodeAtPoint(location);
            
            if node == self.playBtn!
            {
                let nextscene = GameScene(fileNamed: "GameScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
            if node == self.highScoreBtn!
            {
                let nextscene = HighScoresScene(fileNamed: "HighScoresScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);
            }
            if node == self.creditsBtn!
            {
                let nextscene = CreditsScene(fileNamed: "CreditsScene");
                let transition = SKTransition.doorsOpenHorizontalWithDuration(1);
                self.view?.presentScene(nextscene!, transition: transition);

            }
            if node == self.musicBtn!
            {
                MusicEnabled = !MusicEnabled;
            }
            if node == self.soundEffectsBtn!
            {
                SoundEnabled = !SoundEnabled;
            }
            if node == self.vibrationBtn!
            {
                VibrateEnabled = !VibrateEnabled;
            }
        }
    }
}
