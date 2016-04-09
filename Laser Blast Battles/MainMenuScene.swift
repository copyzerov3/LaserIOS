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
    var PlayButton:Button?;
    var HighScoreButton: Button?; //Below^
    var CreditsButton: Button?; //Below^
    //Settings Buttons
    var MusicButton: ToggleButton?; //Bottom Left
    var SoundButton: ToggleButton?; //Right of^
    var VibrationButton: ToggleButton?; //Right of^
    
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        self.titleLbl = createLabel("Laser Blast Battles!", fontSize: 50,
            position: CGPointMake(self.frame.midX, self.frame.height - 140));
        print("Frame height \(self.frame.height)");
        PlayButton = Button(text:"Play");
        PlayButton?.SetPosition(CGPointMake(self.frame.midX - (PlayButton!.GetWidth() / 2), self.frame.midY + PlayButton!.GetHeight()));
        PlayButton?.onPressCode =
        {
            self.view?.presentScene(PlayersSelectScene(fileNamed:"PlayersSelectScene")!,transition:SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 1));
        }
        HighScoreButton = Button(text: "High Scores");
        HighScoreButton?.SetPosition(CGPointMake(PlayButton!.GetX(), PlayButton!.GetY() - PlayButton!.GetHeight() - 35));
        HighScoreButton?.onPressCode =
        {
            self.view?.presentScene(HighScoresScene(fileNamed:"HighScoresScene")!,transition:SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 1));
        }
        CreditsButton = Button(text:"Credits");
        CreditsButton?.SetPosition(CGPointMake(HighScoreButton!.GetX(), HighScoreButton!.GetY() - HighScoreButton!.GetHeight() - 35));
        CreditsButton?.onPressCode =
        {
            self.view?.presentScene(CreditsScene(fileNamed:"CreditsScene")!,transition:SKTransition.revealWithDirection(SKTransitionDirection.Left,duration: 1));
        }
        MusicButton = ToggleButton(text:"Music");
        MusicButton?.SetPosition(CGPointMake(35,MusicButton!.GetHeight() + 35));
        MusicButton?.onPressCode =
        {
            MusicEnabled = !MusicEnabled;
        }
        SoundButton = ToggleButton(text:"Sound");
        SoundButton?.SetPosition(CGPointMake(MusicButton!.GetX() + MusicButton!.GetWidth() + 15, MusicButton!.GetY()));
        SoundButton?.onPressCode =
        {
            SoundEnabled = !SoundEnabled;
        }
        VibrationButton = ToggleButton(text:"Vib");
        VibrationButton?.SetPosition(CGPointMake(SoundButton!.GetX() + SoundButton!.GetWidth() + 15,SoundButton!.GetY()));
        VibrationButton?.onPressCode =
        {
            VibrateEnabled = !VibrateEnabled;
        }
        self.addChild(titleLbl!);
        self.addChild(PlayButton!);
        self.addChild(HighScoreButton!);
        self.addChild(CreditsButton!);
        self.addChild(MusicButton!);
        self.addChild(SoundButton!);
        self.addChild(VibrationButton!);
        
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
        PlayButton?.touchesMoved(touches, withEvent: event);
        HighScoreButton?.touchesMoved(touches, withEvent: event);
        CreditsButton?.touchesMoved(touches, withEvent: event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        PlayButton?.touchesEnded(touches,withEvent:event);
        HighScoreButton?.touchesEnded(touches, withEvent: event);
        CreditsButton?.touchesEnded(touches,withEvent:event);
    }
}
