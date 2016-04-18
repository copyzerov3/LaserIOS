//
//  Button.swift
//  LaserBlastBattles
//
//  Created by Tech on 2016-03-21.
//  Copyright © 2016 GBC. All rights reserved.
//  By Doug McGill 100734413
// 
//This Button is reusable and is based on a 16 by 9 ratio taking up 10 percent on each axis.
//You can set what the button will fire by setting the onPressCode variable to what ever you like.
//Thing to note is the coordinate system is a tad wonky and 0,0 of the images is the top of the container and the container draws from the bottom so for example if you want to show this you need the y positon = height for it to be at zero one day I will fix this

import SpriteKit
import AudioToolbox

class Button:SKNode
{
    var ButtonRegularState = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 160, height: 90))
    var ButtonPressedState = SKShapeNode(rect: CGRect(x:0,y:0,width: 160,height:90));
    let ButtonLabel = SKLabelNode(fontNamed: "Chalkduster");
    var IsPressed:Bool = false;
    var onPressCode:(()-> Void)?;
    init(text:String)
    {
        super.init();
        InitTheRest(text);
    }
    init(text:String, width:CGFloat, height:CGFloat)
    {
        super.init();
        ButtonPressedState = SKShapeNode(rect: CGRect(x:0,y:0,width:width,height:height));
        ButtonRegularState = SKShapeNode(rect:CGRect(x:0,y:0,width:width, height:height));
        InitTheRest(text);
    }
    private func InitTheRest(text:String)
    {
        ButtonLabel.text = text;
        ButtonLabel.fontSize = 25;
        ButtonLabel.fontColor = UIColor.blackColor();
        ButtonRegularState.fillColor = UIColor.whiteColor();
        ButtonPressedState.fillColor = UIColor.grayColor();
        self.addChild(ButtonRegularState);
        self.addChild(ButtonPressedState);
        self.addChild(ButtonLabel);
        ButtonPressedState.alpha = 0;
        PositionLabel();
        self.userInteractionEnabled = true;

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func GetWidth()->CGFloat
    {
        return self.ButtonRegularState.frame.width;
    }
    func GetHeight()->CGFloat
    {
        return self.ButtonRegularState.frame.height;
    }
    private func PositionLabel()
    {
        ButtonLabel.position = CGPointMake(CGRectGetMidX(ButtonRegularState.frame), CGRectGetMidY(ButtonRegularState.frame)-10);
    }
    func GetX()->CGFloat
    {
        return self.position.x;
    }
    func GetY()->CGFloat
    {
        return self.position.y;
    }
    func SetX(x:CGFloat)
    {
        self.position.x = x;
    }
    func SetY(y:CGFloat)
    {
        self.position.y = y;
    }
    func SetPosition(Position:CGPoint)
    {
        self.position = Position;
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        IsPressed = true;
        ButtonRegularState.alpha = 0;
        ButtonPressedState.alpha = 1;
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first!;
        let point:CGPoint = touch.locationInNode(self);
        if(ButtonRegularState.containsPoint(point))
        {
            ButtonRegularState.alpha = 0;
            ButtonPressedState.alpha = 1;
        }
        else
        {
            ButtonPressedState.alpha = 0;
            ButtonRegularState.alpha = 1;
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first!;
        let point:CGPoint = touch.locationInNode(self);
        if(ButtonRegularState.containsPoint(point))
        {
            IsPressed = false;
            ButtonPressedState.alpha = 0;
            ButtonRegularState.alpha = 1;
            onPressCode!();
            if(SoundEnabled)
            {
                self.runAction(SKAction.playSoundFileNamed("tapButtonSound.mp3", waitForCompletion: false));
            }
            if(VibrateEnabled)
            {
           //     AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            }

        }
    }
}

