//
//  GameScene.swift
//  Laser Blast Battles
//
//  Created by Swift on 2016-03-27.
//  Copyright (c) 2016 Swift. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
    //UI Variables
    var PauseButton:Button = Button(text: "Pause");
    var PlayerOneButton:Button = Button(text: "TAP", width: 90, height: 90);
    var PlayerTwoButton:Button = Button(text: "TAP", width: 90, height: 90);
    
    var NumOfPlayer = 0;
    
    let STATE_PLAYING = 0;
    let STATE_PAUSED = 1;
    let STATE_CONFIRMING = 2;
    let STATE_ROUND_BEGINNING = 3;
    
    var GameState = 0;
    
    var PlayerOne = Player(color:UIColor.blueColor());
    var PlayerTwo = Player(color:UIColor.redColor());
    //SinglePlayer Values
    var GameMode:Int = 0; //1 = Time Trial & 2 = Marathon
    var Difficulty:Int = 0; //1 = Easy & 2 = Medium & 3 = Hard
    
    //Multiplayer Values
    var Rounds:Int = 0;
    var PowerUpsRate:Int = 0;
    var TimePerRound:Int = 0;
    //variable used on Jarrett's Computer because the height is randomly shrunk on his computer.
    var indent: CGFloat = 95.0;
    
    //Powerup Variables
    var powerupTimer = 5.0;
    var timerDelay = 5.0;
    var powerup: SKSpriteNode?;
    var Timer:NSTimer = NSTimer();
    
    //Jarrett's temp score variables
    var score = 0;
    var highscore = 0;
    
    var HighscoreDefault = NSUserDefaults.standardUserDefaults();
    // tEasy, tMedium, tHard, mEasy, mMedium, mHard
    
    
    //Containers for different states
    var pauseContainer:PauseContainer?;
    var confirmationContainer:ConfirmationContainer?;
    
    //Init For single player
    init(size: CGSize,GameMode:Int,Difficulty:Int)
    {
        super.init(size: size);
        self.GameMode = GameMode;
        self.Difficulty = Difficulty;
        NumOfPlayer = 1;
    }
    //Init for multiplayer
    init(size:CGSize,PowerUps:Int, Timer:Int,Rounds:Int)
    {
        super.init(size:size);
        self.PowerUpsRate = PowerUps;
        self.TimePerRound = Timer;
        NumOfPlayer = 2;
        self.Rounds = Rounds;
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func didMoveToView(view: SKView) //creates the scene
    {
        self.scaleMode = .AspectFill
        GameState = STATE_PLAYING;
        PauseButton.SetPosition(CGPointMake(self.frame.midX - (PauseButton.GetWidth() / 2), PauseButton.GetHeight()));
        PlayerOneButton.SetPosition(CGPointMake(35, PlayerOneButton.GetHeight()));
        PlayerTwoButton.SetPosition(CGPointMake(self.frame.width - PlayerTwoButton.GetWidth(),PlayerOneButton.GetY()));
        PauseButton.onPressCode =
        {
            if(self.GameState == self.STATE_PLAYING)
            {
                self.ChangeState(self.STATE_PAUSED);
            }
        }
        PlayerOneButton.onPressCode =
        {
            if(self.GameState == self.STATE_PLAYING)
            {
                self.PlayerTwo.LowerPower(self.PlayerOne.AddPower());
            }
        }
        PlayerTwoButton.onPressCode =
        {
            if(self.GameState == self.STATE_PLAYING)
            {
                self.PlayerOne.LowerPower(self.PlayerTwo.AddPower());
            }
        }
        PlayerOne.position = CGPointMake(100,self.frame.height/2);
        PlayerTwo.position = CGPointMake(self.frame.width - PlayerTwo.PlayerImage.frame.width - 100, PlayerOne.position.y);
        
        PlayerOne.MaxLengthOfLaser = Float(PlayerTwo.position.x - (PlayerOne.position.x + PlayerOne.PlayerImage.frame.width));
        print("Player One X = \(PlayerOne.position.x) PlayerOne Width = \(PlayerOne.PlayerImage.frame.width) PlayerTwo Position = \(PlayerTwo.position.x)");
        PlayerTwo.MaxLengthOfLaser = PlayerOne.MaxLengthOfLaser;
        PlayerTwo.direction = 1;
        
        PlayerOne.StartLaser();
        PlayerTwo.StartLaser();
        
        addChild(PauseButton);
        addChild(PlayerOneButton);
        addChild(PlayerOne);
        addChild(PlayerTwo);
        if(NumOfPlayer == 2)
        {
            addChild(PlayerTwoButton);
        }
        
        pauseContainer = PauseContainer(width: frame.width, height: frame.height);
      // pauseContainer?.position.y = frame.height;
        pauseContainer?.CloseButton.onPressCode =
        {
            if(self.GameState == self.STATE_PAUSED)
            {
                self.ChangeState(self.STATE_PLAYING);
            }
        }
        pauseContainer?.QuitButton.onPressCode =
        {
            if(self.GameState == self.STATE_PAUSED)
            {
                self.ChangeState(self.STATE_CONFIRMING);
            }
        }
        confirmationContainer = ConfirmationContainer(width:frame.width, height:frame.height);
        confirmationContainer?.YesButton.onPressCode =
        {
            if(self.GameState == self.STATE_CONFIRMING)
            {
                self.view?.presentScene(MainMenuScene(fileNamed: "MainMenuScene")!,transition:SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
            }
        }
        confirmationContainer?.NoButton.onPressCode =
        {
            if(self.GameState == self.STATE_CONFIRMING)
            {
                self.ChangeState(self.STATE_PAUSED);
            }
        }
        
        //Timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target:self, selector: "Fuckyou", userInfo: nil, repeats: false);
        Timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target:self, selector: ("spawnPowerup"), userInfo: nil, repeats: true);
        
        //sets the highscore for the gamemode
        if (NumOfPlayer == 1)
        {
            if (self.GameMode == 1) //Time Trial
            {
                if (self.Difficulty == 1)
                {
                    highscore = HighscoreDefault.valueForKey("tEasy") as! NSInteger;
                }
                if (self.Difficulty == 2)
                {
                    highscore = HighscoreDefault.valueForKey("tMedium") as! NSInteger;
                }
                if (self.Difficulty == 3)
                {
                    highscore = HighscoreDefault.valueForKey("tHard") as! NSInteger;
                }
            }
            else if (self.GameMode == 2) //Marathon
            {
                if (self.Difficulty == 1)
                {
                    highscore = HighscoreDefault.valueForKey("mEasy") as! NSInteger;
                }
                if (self.Difficulty == 2)
                {
                    highscore = HighscoreDefault.valueForKey("mMedium") as! NSInteger;
                }
                if (self.Difficulty == 3)
                {
                    highscore = HighscoreDefault.valueForKey("mHard") as! NSInteger;
                }
            }
        }
    }
    func ChangeState(state:Int)
    {
        if(state == STATE_PAUSED)
        {
            addChild(pauseContainer!);
            PauseButton.ButtonLabel.alpha = 0;
            PlayerOneButton.ButtonLabel.alpha = 0;
            PlayerTwoButton.ButtonLabel.alpha = 0;
            if(self.GameState == STATE_CONFIRMING)
            {
                confirmationContainer?.removeFromParent();
            }
        }
        else if(state == STATE_CONFIRMING)
        {
            pauseContainer?.removeFromParent();
            addChild(confirmationContainer!);
        }
        else if(state == STATE_PLAYING)
        {
            pauseContainer?.removeFromParent();
            PauseButton.ButtonLabel.alpha = 1;
            PlayerOneButton.ButtonLabel.alpha = 1;
            PlayerTwoButton.ButtonLabel.alpha = 1;

        }
        GameState = state;
    }
    func spawnPowerup() //spawns a powerup randomly on the game screen
    {
        if(GameState == STATE_PLAYING)
        {
            //if let someNodeExist = self.powerup
            //let someNodeExist = self.childNodeWithName("powerup");
            //if someNodeExist == powerup
            if self.powerup == nil
            {
                //Doesnt randomize location yet.
                let newPowerup = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 50, height: 50));
                newPowerup.position = CGPointMake(self.frame.midX ,self.frame.midY);
                self.powerup = newPowerup;
                self.addChild(self.powerup!);
                //return newPowerup;
            }
            else
            {
                self.powerup?.removeFromParent();
                self.powerup = nil;
            }
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

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) //Handles touches
    {
       /* Called when a touch begins */
        for touch in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if (self.powerup != nil && node == self.powerup!)
            {
                //kills the powerup
                self.powerup?.removeFromParent();
                self.powerup = nil;
            }

        }
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
}
