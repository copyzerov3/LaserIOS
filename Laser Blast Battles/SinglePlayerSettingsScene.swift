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
    var BackButton:Button = Button(text:"Back");
    var TimeTrialButton:ToggleButton = ToggleButton(text: "Time Trial", width: 160, height: 90);
    var MarathonButton:ToggleButton = ToggleButton(text: "Marathon", width: 160, height: 90);
    var EasyButton:ToggleButton = ToggleButton(text: "Easy", width: 160, height: 90);
    var MediumButton:ToggleButton = ToggleButton(text: "Medium", width: 160, height: 90);
    var HardButton:ToggleButton = ToggleButton(text:"Hard",width:160,height:90);
    var PlayButton:Button = Button(text:"Play");
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    //Used to determine which mode is selected and what difficulty is selected
    var GameMode:Int = 0;
    var Difficulty:Int = 0;
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("Choose your mode", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.height - 140));
        self.diffLbl = createLabel("Difficulty", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.midY + 20));
        self.helpLbl = createLabel("Explains what the mode is that is selected", fontSize: 40,
            position: CGPointMake(self.frame.midX, 0));
        
        PlayButton.SetPosition(CGPointMake(self.frame.width - PlayButton.GetWidth(), self.frame.height - (PlayButton.GetHeight() * 2)));
        PlayButton.onPressCode =
        {
            if(self.GameMode != 0 && self.Difficulty != 0)
            {
                self.view?.presentScene(GameScene(fileNamed: "GameScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
            }
        }
        TimeTrialButton.SetPosition(CGPointMake(self.frame.width/3 - (TimeTrialButton.GetWidth() / 2), self.frame.midY + 100));
        TimeTrialButton.onPressCode =
        {
            self.GameMode = 1;
            self.helpLbl?.removeFromParent();
            self.helpLbl = self.createLabel("Tap as fast as you can to get a good time!", fontSize: 40,
                        position: CGPointMake(self.frame.midX, 200));
            self.MarathonButton.SetIsActive(false);
            self.addChild(self.helpLbl!);
        }
        MarathonButton.SetPosition(CGPointMake(self.frame.width/3*2 - (MarathonButton.GetWidth() / 2), self.frame.midY + 100));
        MarathonButton.onPressCode =
        {
            self.GameMode = 2;
            self.helpLbl?.removeFromParent();
            self.helpLbl = self.createLabel("Tap till your fingers drop!", fontSize: 40,
                                            position: CGPointMake(self.frame.midX, 200));
            self.TimeTrialButton.SetIsActive(false);
            self.addChild(self.helpLbl!);
        }
        EasyButton.SetPosition(CGPointMake(self.frame.width/6*2 - (EasyButton.GetWidth() / 2), self.frame.midY - 100));
        EasyButton.onPressCode =
        {
            self.Difficulty = 1;
            self.MediumButton.SetIsActive(false);
            self.HardButton.SetIsActive(false);
        }
        MediumButton.SetPosition(CGPointMake(self.frame.width/6*3 - (MediumButton.GetWidth() / 2), self.frame.midY - 100));
        MediumButton.onPressCode =
        {
            self.Difficulty = 2;
            self.EasyButton.SetIsActive(false);
            self.HardButton.SetIsActive(false);
        }
        HardButton.SetPosition(CGPointMake(self.frame.width/6*4 - (HardButton.GetWidth() / 2), self.frame.midY - 100));
        HardButton.onPressCode =
        {
            self.Difficulty = 3;
            self.EasyButton.SetIsActive(false);
            self.MediumButton.SetIsActive(false);
        }
        BackButton.SetPosition(CGPointMake(0, self.frame.height - (BackButton.GetHeight() * 2)));
        BackButton.onPressCode =
        {
            self.view?.presentScene(PlayersSelectScene(fileNamed: "PlayersSelectScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
        }
        addChild(BackButton);
        addChild(PlayButton);
        addChild(MarathonButton);
        addChild(TimeTrialButton);
        addChild(EasyButton);
        addChild(MediumButton);
        addChild(HardButton);
        self.addChild(titleLbl!);
        self.addChild(diffLbl!);
        self.addChild(helpLbl!);
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
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        PlayButton.touchesMoved(touches, withEvent: event);
        BackButton.touchesMoved(touches, withEvent: event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        PlayButton.touchesEnded(touches, withEvent: event);
        BackButton.touchesEnded(touches, withEvent: event);
    }
}