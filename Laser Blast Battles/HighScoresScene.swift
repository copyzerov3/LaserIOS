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
    var BackButton:Button = Button(text:"Back");
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    //Used to Load and Save Highscores locally
    var HighscoreDefault = NSUserDefaults.standardUserDefaults();
    var timeEasy = 0;
    var timeMed = 0;
    var timeHigh = 0;
    var maraEasy = 0;
    var maraMed = 0;
    var maraHigh = 0;
    
    override func didMoveToView(view: SKView) //Creates the Scene
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("Laser Blast Battle High Scores", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 140));
        
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
        
        BackButton.SetPosition(CGPointMake(0,self.frame.height - BackButton.GetHeight() * 2));
        BackButton.onPressCode =
        {
            self.view?.presentScene(MainMenuScene(fileNamed: "MainMenuScene")!,transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
        }
        self.addChild(titleLbl!);
        self.addChild(titleTimeLbl!);
        self.addChild(timeEasyLbl!);
        self.addChild(timeMedLbl!);
        self.addChild(timeHardLbl!);
        self.addChild(titleMarathonLbl!);
        self.addChild(maraEasyLbl!);
        self.addChild(maraMedLbl!);
        self.addChild(maraHardLbl!);
        self.addChild(BackButton);
        
        if (HighscoreDefault.valueForKey("Highscore") != nil)
        {
            timeEasy = HighscoreDefault.valueForKey("Highscore") as! NSInteger;
            timeEasyLbl?.text = NSString(format: "Easy: %i", timeEasy) as String;
        }
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
        BackButton.touchesMoved(touches, withEvent: event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        BackButton.touchesEnded(touches, withEvent: event);
    }
    
}