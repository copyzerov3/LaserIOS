//
//  GameOverScene.swift
//  Laser Blast Battles
//
//  Created by Tech on 2016-04-11.
//  Copyright © 2016 Swift. All rights reserved.
//

import SpriteKit

class GameOverScene:SKScene
{
    let MainMenuButton:Button = Button(text:"Main Menu");
    let AgainButton:Button = Button(text:"Again");
    
    var GameMode:Int = 0;
    var Difficulty:Int = 0;
    
    var PowerUps:Int = 0;
    var TimePerRound:Int = 0;
    var Rounds:Int = 0;
    
    var Winner:Int = 0;
    var Value:Int = 0;
    //the value meaning is determined by the game mode either time taken or rounds completed
    init(size:CGSize,GameMode:Int, Difficulty:Int,value:Int)
    {
        super.init(size:size);
        self.GameMode = GameMode;
        self.Difficulty = Difficulty;
        self.Value = value;
    }
    init(size:CGSize, PowerUps:Int, TimePerRound:Int, Rounds:Int,Winner:Int)
    {
        super.init(size:size);
        self.PowerUps = PowerUps;
        self.TimePerRound = TimePerRound;
        self.Rounds = Rounds;
        self.Winner = Winner;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) //creates the Scene
    {
       self.scaleMode = .AspectFill;
        
        let Title = SKLabelNode(fontNamed: "Chalkduster");
        Title.fontSize = 45;
        Title.text = "Game Over";
        Title.fontColor = UIColor.blackColor();
        Title.position = CGPointMake(self.frame.midX,self.frame.height - 200);
        if(Winner != 0)
        {
            let WinnerLabel = SKLabelNode(fontNamed:"Chalkduster");
            WinnerLabel.fontSize = 35;
            WinnerLabel.text = "Player \(Winner) Won!";
            WinnerLabel.fontColor = UIColor.blackColor();
            WinnerLabel.position = CGPointMake(self.frame.midX, self.frame.height - 250);
            addChild(WinnerLabel);
        }
        if(Value != 0)
        {
            let LevelLabel = SKLabelNode(fontNamed: "Chalkduster");
            LevelLabel.fontSize = 25;
            if(GameMode == 1)
            {
                LevelLabel.text = "Completed Time Trial in \(Value) seconds";
            }
            else
            {
                LevelLabel.text = "Completed \(Value) rounds in marathon mode congratulations";
            }
            LevelLabel.fontColor = UIColor.blackColor();
            LevelLabel.position = CGPointMake(self.frame.midX,self.frame.height - 250);
            addChild(LevelLabel);
        }
        MainMenuButton.SetPosition(CGPointMake(((self.frame.width / 3) * 2) - (MainMenuButton.GetWidth() / 2),self.frame.midY - MainMenuButton.GetHeight()));
        AgainButton.SetPosition(CGPointMake((self.frame.width / 3) - (AgainButton.GetWidth() / 2),self.frame.midY - AgainButton.GetHeight()));
        MainMenuButton.onPressCode =
        {
            self.view?.presentScene(MainMenuScene(fileNamed:"MainMenuScene")!, transition: SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
        }
        
        AgainButton.onPressCode =
        {
            if(self.GameMode == 0)
            {
                self.view?.presentScene(GameScene(size: self.size, PowerUps:self.PowerUps, Timer: self.TimePerRound, Rounds: self.Rounds), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
            }
            else
            {
                self.view?.presentScene(GameScene(size: self.size,GameMode: self.GameMode,Difficulty: self.Difficulty), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 1));
            }
        }
        addChild(Title);
        addChild(MainMenuButton);
        addChild(AgainButton);
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        MainMenuButton.touchesMoved(touches, withEvent: event);
        AgainButton.touchesMoved(touches, withEvent: event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        MainMenuButton.touchesEnded(touches, withEvent: event);
        AgainButton.touchesEnded(touches, withEvent: event);
    }
}
