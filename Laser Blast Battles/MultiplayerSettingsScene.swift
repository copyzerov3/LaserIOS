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
    var PlayButton:Button = Button(text:"Play");
    var BackButton:Button = Button(text: "Back");
    //power ups
    var PowerUpsNoneButton: ToggleButton = ToggleButton(text:"None");
    var PowerUpsLowButton: ToggleButton = ToggleButton(text:"Low");
    var PowerUpsMediumButton:ToggleButton = ToggleButton(text:"Med");
    var PowerUpsHighButton:ToggleButton = ToggleButton(text:"High");
    //time
    var TimerNoneButton: ToggleButton = ToggleButton(text:"None");
    var TimerLowButton: ToggleButton = ToggleButton(text:"30");
    var TimerMediumButton:ToggleButton = ToggleButton(text:"60");
    var TimerHighButton:ToggleButton = ToggleButton(text:"90");
    //rounds
    var RoundsLowButton:ToggleButton = ToggleButton(text:"3");
    var RoundsMediumButton:ToggleButton = ToggleButton(text:"5");
    var RoundsHighButton:ToggleButton = ToggleButton(text:"7");
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    //used to pass variables to the game scene
    var PowerUps:Int = 2;
    var Timers:Int = 60;
    var Rounds:Int = 5;
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        PowerUpsMediumButton.SetIsActive(true);
        TimerMediumButton.SetIsActive(true);
        RoundsMediumButton.SetIsActive(true);
        self.titleLbl = createLabel("Multiplayer Settings", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 140));
        self.inst1Lbl = createLabel("Amount of Power ups that show up during play", fontSize: 30,
            position: CGPointMake(self.frame.midX, self.frame.midY + 180));
        self.inst2Lbl = createLabel("The length of each round", fontSize: 30,
            position: CGPointMake(self.frame.midX, self.frame.midY + 30));
        self.inst3Lbl = createLabel("The amount of rounds", fontSize: 30,
            position: CGPointMake(self.frame.midX, self.frame.midY - 110));
        
      /*  self.powerLbl = createLabel("Power Ups:", fontSize: 40,
            position: CGPointMake(self.frame.midX/5, self.frame.midY + 75));
        self.timerLbl = createLabel("Timer:", fontSize: 40,
            position: CGPointMake(self.frame.midX/7, self.frame.midY - 25));
        self.roundLbl = createLabel("Rounds:", fontSize: 40,
            position: CGPointMake(self.frame.midX/6, self.frame.midY - 125));*/
        
        BackButton.SetPosition(CGPointMake(0,self.frame.height - (BackButton.GetHeight() * 2)));
        BackButton.onPressCode =
        {
            self.view?.presentScene(PlayersSelectScene(fileNamed:"PlayersSelectScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
        }
        PlayButton.SetPosition(CGPointMake(self.frame.width - PlayButton.GetWidth(),self.frame.height - (PlayButton.GetHeight() * 2)));
        PlayButton.onPressCode =
        {
            self.view?.presentScene(GameScene(fileNamed:"GameScene")!,transition: SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
        }
        PowerUpsNoneButton.SetPosition(CGPointMake(self.frame.width/7*2 - (PowerUpsNoneButton.GetWidth() / 2), self.frame.midY + 60));
        PowerUpsNoneButton.onPressCode =
        {
            self.PowerUps = 0;
            self.PowerUpsLowButton.SetIsActive(false);
            self.PowerUpsMediumButton.SetIsActive(false);
            self.PowerUpsHighButton.SetIsActive(false);
        }
        PowerUpsLowButton.SetPosition(CGPointMake(self.frame.width/7*3 - (PowerUpsNoneButton.GetWidth() / 2), PowerUpsNoneButton.GetY()));
        PowerUpsLowButton.onPressCode =
        {
            self.PowerUps = 1;
            self.PowerUpsNoneButton.SetIsActive(false);
            self.PowerUpsMediumButton.SetIsActive(false);
            self.PowerUpsHighButton.SetIsActive(false)
        }
        
        PowerUpsMediumButton.SetPosition(CGPointMake(self.frame.width/7*4 - (PowerUpsNoneButton.GetWidth() / 2), PowerUpsNoneButton.GetY()));
        PowerUpsMediumButton.onPressCode =
        {
            self.PowerUps = 2;
            self.PowerUpsNoneButton.SetIsActive(false);
            self.PowerUpsLowButton.SetIsActive(false);
            self.PowerUpsHighButton.SetIsActive(false);
        }
        PowerUpsHighButton.SetPosition(CGPointMake(self.frame.width/7*5 - (PowerUpsNoneButton.GetWidth() / 2), PowerUpsNoneButton.GetY()));
        PowerUpsHighButton.onPressCode =
        {
            self.PowerUps = 3;
            self.PowerUpsNoneButton.SetIsActive(false);
            self.PowerUpsLowButton.SetIsActive(false);
            self.PowerUpsMediumButton.SetIsActive(false);
        }
        
        TimerNoneButton.SetPosition(CGPointMake(self.frame.width/7*2 - (TimerNoneButton.GetWidth() / 2), self.frame.midY - 90));
        TimerNoneButton.onPressCode =
        {
            self.Timers = 0;
            self.TimerLowButton.SetIsActive(false);
            self.TimerMediumButton.SetIsActive(false);
            self.TimerHighButton.SetIsActive(false);
        }
        TimerLowButton.SetPosition(CGPointMake(self.frame.width/7*3 - (TimerNoneButton.GetWidth() / 2), TimerNoneButton.GetY()));
        TimerLowButton.onPressCode =
        {
            self.Timers = 30;
            self.TimerNoneButton.SetIsActive(false);
            self.TimerMediumButton.SetIsActive(false);
            self.TimerHighButton.SetIsActive(false);
        }
        TimerMediumButton.SetPosition(CGPointMake(self.frame.width/7*4 - (TimerNoneButton.GetWidth() / 2), TimerLowButton.GetY()));
        TimerMediumButton.onPressCode =
        {
            self.Timers = 60;
            self.TimerLowButton.SetIsActive(false);
            self.TimerNoneButton.SetIsActive(false);
            self.TimerHighButton.SetIsActive(false);
        }
        TimerHighButton.SetPosition(CGPointMake(self.frame.width/7*5 - (TimerNoneButton.GetWidth() / 2), TimerLowButton.GetY()));
        TimerHighButton.onPressCode =
        {
            self.Timers = 90;
            self.TimerLowButton.SetIsActive(false);
            self.TimerMediumButton.SetIsActive(false);
            self.TimerNoneButton.SetIsActive(false);
        }
        
        RoundsLowButton.SetPosition(CGPointMake(self.frame.width/6*2 - (RoundsLowButton.GetWidth() / 2), self.frame.midY - 235));
        RoundsLowButton.onPressCode =
        {
            self.Rounds = 3;
            self.RoundsMediumButton.SetIsActive(false);
            self.RoundsHighButton.SetIsActive(false);
        }
        
        
        RoundsMediumButton.SetPosition(CGPointMake(self.frame.width/6*3 - (RoundsLowButton.GetWidth() / 2), RoundsLowButton.GetY()));
        RoundsMediumButton.onPressCode =
        {
            self.Rounds = 5;
            self.RoundsLowButton.SetIsActive(false);
            self.RoundsHighButton.SetIsActive(false);
        }
        RoundsHighButton.SetPosition(CGPointMake(self.frame.width/6*4 - (RoundsLowButton.GetWidth() / 2), RoundsLowButton.GetY()));
        RoundsHighButton.onPressCode =
        {
            self.Rounds = 7;
            self.RoundsMediumButton.SetIsActive(false);
            self.RoundsLowButton.SetIsActive(false);
        }
        
        self.addChild(titleLbl!);
        self.addChild(inst1Lbl!);
        self.addChild(inst2Lbl!);
        self.addChild(inst3Lbl!);
        /*self.addChild(powerLbl!);
        self.addChild(timerLbl!);
        self.addChild(roundLbl!);*/
        
        addChild(BackButton);
        addChild(PlayButton);
        
        addChild(RoundsHighButton);
        addChild(RoundsMediumButton);
        addChild(RoundsLowButton);
        addChild(TimerHighButton)
        addChild(TimerMediumButton);
        addChild(TimerLowButton);
        addChild(TimerNoneButton);
        addChild(PowerUpsMediumButton);
        addChild(PowerUpsLowButton);
        addChild(PowerUpsNoneButton);
        addChild(PowerUpsHighButton)
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
        PlayButton.touchesMoved(touches, withEvent: event);
        BackButton.touchesMoved(touches,withEvent:event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        PlayButton.touchesEnded(touches, withEvent: event);
        BackButton.touchesEnded(touches, withEvent: event);
    }
}