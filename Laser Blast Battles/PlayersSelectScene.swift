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
    var BackButton:Button = Button(text: "Back");
    var OnePlayerButton:Button = Button(text: "One Player");
    var TwoPlayerButton:Button = Button(text:"Two Player");
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
        self.scaleMode = .AspectFill;
        
        self.titleLbl = createLabel("How Many Players?", fontSize: 40,
            position: CGPointMake(self.frame.midX, self.frame.height - 140));
        
        OnePlayerButton.SetPosition(CGPointMake(self.frame.width/3 - (OnePlayerButton.GetWidth() / 2), self.frame.midY));
        OnePlayerButton.onPressCode =
        {
            self.view?.presentScene(SinglePlayerSettingsScene(fileNamed:"SinglePlayerSettingsScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
        }
        TwoPlayerButton.SetPosition(CGPointMake(self.frame.width/3*2 - (TwoPlayerButton.GetWidth() / 2), self.frame.midY));
        TwoPlayerButton.onPressCode =
        {
            self.view?.presentScene(MultiplayerSettingsScene(fileNamed:"MultiplayerSettingsScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
        }
        
        BackButton.SetPosition(CGPointMake(0,self.frame.height - (BackButton.GetHeight()*2)));
        BackButton.onPressCode =
        {
            self.view?.presentScene(MainMenuScene(fileNamed: "MainMenuScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
        }
        
        self.addChild(titleLbl!);
        addChild(BackButton);
        addChild(OnePlayerButton);
        addChild(TwoPlayerButton);
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
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        OnePlayerButton.touchesEnded(touches, withEvent: event);
        TwoPlayerButton.touchesEnded(touches, withEvent: event);
        BackButton.touchesEnded(touches, withEvent: event);
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        OnePlayerButton.touchesMoved(touches, withEvent: event);
        TwoPlayerButton.touchesMoved(touches, withEvent: event);
        BackButton.touchesMoved(touches, withEvent: event);
    }
}