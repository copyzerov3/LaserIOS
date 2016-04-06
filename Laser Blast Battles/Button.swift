//
//  Button.swift
//  LaserBlastBattles
//
//  Created by Tech on 2016-03-21.
//  Copyright © 2016 GBC. All rights reserved.
//  By Doug McGill 100734413
// 
//  This is used for our buttons and you can swap out the images used using the init which takes two images
//  It uses a closure as a callback for when the button is released;

import SpriteKit

class Button:SKNode
{
    let ButtonRegularState = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 160, height: 90))
    let ButtonPressedState = SKShapeNode(rect: CGRect(x:0,y:0,width: 160,height:90));
    let ButtonLabel = SKLabelNode(fontNamed: "Chalkduster");
    var IsPressed:Bool = false;
    var onPressCode:(()-> Void)?;
    init(text:String)
    {
        super.init();
        ButtonLabel.text = text;
        ButtonLabel.fontSize = 45;
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
        return self.frame.width;
    }
    func GetHeight()->CGFloat
    {
        return self.frame.height;
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
        var pos = Position;
        pos.x -= (ButtonRegularState.frame.width/2);
        pos.y -= (ButtonRegularState.frame.height/2);
        self.position = pos;
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

        }
    }
}

