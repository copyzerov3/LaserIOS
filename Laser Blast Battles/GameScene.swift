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
    // 1= time 2 = marathon
    var GameState = 0;
    
    var PlayerOne = Player(color:UIColor.blueColor());
    var PlayerTwo = Player(color:UIColor.redColor());
    //SinglePlayer Values
    var GameMode:Int = 0; //1 = Time Trial & 2 = Marathon
    var Difficulty:Int = 0; //1 = Easy & 2 = Medium & 3 = Hard
    
    //Multiplayer Values
    var Rounds:Int = 0;
    var PowerUpsRate:Int = 0;
    var TimePerRound:Int = 60;
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
    
    var CurrentRound:Int = 1;
    var RoundTime:Int = 0;
    var RoundTimer:NSTimer = NSTimer();
    
    var AITimer:NSTimer = NSTimer();
    
    var TimeLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster");
    var RoundLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster");
    var PlayerOneWinsLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster");
    var PlayerTwoWinsLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster");
    
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
        switch(Difficulty)
        {
        case 1:
            Rounds = 10;
            break;
        case 2:
            Rounds = 15;
            break;
        case 3:
            Rounds = 20;
            break;
        default:
            Rounds = 0;
        }
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
    
    private func Reset()
    {
        SetAITimer();
        RoundTime = 0;
        TimeLabel.text = "\(TimePerRound - RoundTime)";
        PlayerOne.SetPower(50);
        PlayerTwo.SetPower(50);
    }
    override func didMoveToView(view: SKView) //creates the scene
    {
        self.scaleMode = .AspectFill
        GameState = STATE_PLAYING;
        TimeLabel.position = CGPointMake(self.frame.midX, self.frame.height - 120 );
        TimeLabel.fontSize = 25;
        TimeLabel.text = "\(TimePerRound - RoundTime)";
        if(TimePerRound != 0)
        {
            addChild(TimeLabel);
        }
        
        RoundLabel.position = CGPointMake(self.frame.midX, self.frame.height - 150);
        RoundLabel.fontSize = 25;
        if(GameMode == 2)
        {
            RoundLabel.text = "Rounds Completed : \(CurrentRound-1)";
        }
        else
        {
            RoundLabel.text = "Round \(CurrentRound) of \(Rounds)";
        }
        
        addChild(RoundLabel);
        
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
                if(self.PlayerOne.GetPower() >= 100)
                {
                    self.CurrentRound += 1;
                    self.PlayerOneCheckWin();
                }
            }
        }
        PlayerTwoButton.onPressCode =
        {
            if(self.GameState == self.STATE_PLAYING)
            {
                self.PlayerOne.LowerPower(self.PlayerTwo.AddPower());
                if(self.PlayerTwo.GetPower() >= 100)
                {
                    self.PlayerTwoCheckWin();
                }
            }
        }
        PlayerOne.position = CGPointMake(100,self.frame.height/2);
        PlayerTwo.position = CGPointMake(self.frame.width - PlayerTwo.PlayerImage.frame.width - 100, PlayerOne.position.y);
        
        PlayerOne.MaxLengthOfLaser = Float(PlayerTwo.position.x - (PlayerOne.position.x + PlayerOne.PlayerImage.frame.width));
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
        SetAITimer();
        Timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target:self, selector: ("spawnPowerup"), userInfo: nil, repeats: true);
        RoundTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self,selector:"OnRoundTimer",userInfo: nil, repeats:true);
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
    
    func SetAITimer()
    {
        if(AITimer.valid)
        {
            AITimer.invalidate();
        }
        if(NumOfPlayer == 1)
        {
            var time:NSTimeInterval = 0;
            switch(Difficulty)
            {
            case 1:
                time = 0.8;
                break;
            case 2:
                time = 0.6;
                break;
            case 3:
                time = 0.4;
                break;
            default:
                time = 2;
                break;
            }
            AITimer = NSTimer.scheduledTimerWithTimeInterval(time - (Double(CurrentRound) * 0.01), target:self, selector: "OnAIPress",userInfo:nil,repeats:true);
        }

    }
    
    
    func OnRoundTimer()
    {
        if(GameState == STATE_PLAYING)
        {
            self.RoundTime += 1;
        }
        
        self.TimeLabel.text = "\(TimePerRound - RoundTime)";
        
        
        if(TimePerRound - RoundTime == 0)
        {
            if(GameMode == 2)
            {
                 self.view?.presentScene(GameOverScene(size: self.size, GameMode: self.GameMode, Difficulty: self.Difficulty), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
            }
            else
            {
                CurrentRound+=1;
                if(PlayerOne.GetPower()>PlayerTwo.GetPower())
                {
                    PlayerOneCheckWin();
                }
                else if(PlayerOne.GetPower()<PlayerTwo.GetPower())
                {
                    PlayerTwoCheckWin();
                }
                else
                {
                    CurrentRound -= 1;
                    self.RoundLabel.text = "Round \(self.CurrentRound) of \(self.Rounds)";
                }
                Reset();
            }
        }
        
    }
    func PlayerOneCheckWin()
    {
        self.PlayerOne.RoundsWon += 1;
        if(self.GameMode != 2)
        {
            self.RoundLabel.text = "Round \(self.CurrentRound) of \(self.Rounds)";
            let Num:Int = Int(round(Float(self.PlayerOne.RoundsWon) / 2));
            if(self.CurrentRound > self.Rounds || (Num < self.CurrentRound && self.NumOfPlayer == 2))
            {
                if(self.NumOfPlayer == 1)
                {
                    
                    self.view?.presentScene(GameOverScene(size: self.size, GameMode: self.GameMode, Difficulty: self.Difficulty), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
                    
                }
                else
                {
                    self.view?.presentScene(GameOverScene(size: self.size, PowerUps: self.PowerUpsRate, TimePerRound: self.TimePerRound, Rounds: self.Rounds), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
                }
            }
        }//end of not marathon mode
        else
        {
            self.RoundLabel.text = "Rounds Completed : \(self.CurrentRound-1)";
            self.RoundTime = self.TimePerRound;
        }
        self.Reset();
    }
    func PlayerTwoCheckWin()
    {
        if(self.NumOfPlayer == 2)
        {
            if(self.CurrentRound > self.Rounds / 2)
            {
                self.view?.presentScene(GameOverScene(size: self.size, PowerUps: self.PowerUpsRate, TimePerRound: self.TimePerRound, Rounds: self.Rounds), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
            }
            self.CurrentRound += 1;
            self.RoundLabel.text = "Round \(self.CurrentRound) of \(self.Rounds)";
            self.Reset();
        }
        else
        {
            if(self.GameMode == 1)
            {
                self.Reset();
            }
            else
            {
                self.view?.presentScene(GameOverScene(size: self.size, GameMode: self.GameMode, Difficulty: self.Difficulty), transition: SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1));
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
            RoundLabel.alpha = 0;
            TimeLabel.alpha = 0;
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
            RoundLabel.alpha = 1;
            TimeLabel.alpha = 1;

        }
        GameState = state;
    }
    func spawnPowerup() //spawns a powerup randomly on the game screen
    {
        if(GameState == STATE_PLAYING)
        {
            if self.powerup == nil
            {
                let sizeX = Int(CGRectGetMaxX(self.frame));
                let sizeY = Int(CGRectGetMaxY(self.frame));
                let randomX = CGFloat(Int(arc4random()) % sizeX - 50);
                let randomY = CGFloat(Int(arc4random()) % sizeY - 150);
                
                //Doesnt randomize location yet.
                let newPowerup = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 50, height: 50));
                if (randomX <= self.frame.midX)
                {
                    //newPowerup.color = UIColor.blueColor();
                }
                else
                {
                    //newPowerup.color = UIColor.redColor();
                }
                
                newPowerup.position = CGPointMake(randomX , randomY + 100);
                //newPowerup.position = CGPointMake(self.frame.midX ,self.frame.midY);
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
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) //Handles touches
    {
       /* Called when a touch begins */
        for touch in touches
        {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if (self.powerup != nil && node == self.powerup!)
            {
                //Burst -> Call PlayerOneButton.onPressCode orPlayerTwoButton.onPressCode 4 times
                //Switcharoo -> setpower of player 1 to  2 and vice versa
                //Slow Time -> player.swift setpowerscale to 0.5 then have a timer make it 1 again.
                //create a bool stunned for each player and timer it off.
                //Power - > player.swift setpowerscale to 2 then have a timer make it 1 again.
                //kills the powerup
                self.powerup?.removeFromParent();
                self.powerup = nil;
            }

        }
    }
    func OnAIPress()
    {
        PlayerTwoButton.onPressCode!();
        if(self.powerup != nil)
        {
            if(self.powerup?.position.x >= self.frame.midX)
            {
                //Use power Up;
                self.powerup = nil;
            }
        }
    }
    override func update(currentTime: CFTimeInterval)
    {
    }
}
