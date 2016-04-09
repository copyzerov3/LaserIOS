//
//  ToggleButton.swift
//  Laser Blast Battles
//
//  Created by Doug McGill on 2016-04-07.
//  Copyright © 2016 Swift. All rights reserved.
// Same as the regular buttons but this version toggles instead of being a regular button for specifics in positioning and usage see Button

import SpriteKit

class ToggleButton:SKNode
{
    var ButtonRegularState = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 90, height: 90))
    var ButtonPressedState = SKShapeNode(rect: CGRect(x:0,y:0,width: 90,height:90));
    let ButtonLabel = SKLabelNode(fontNamed: "Chalkduster");
    var onPressCode:(()-> Void)?;
    
    var IsActive:Bool = false;
    init(text:String)
    {
        super.init();
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
    init(text:String, width:CGFloat,height:CGFloat)
    {
        super.init();
        ButtonRegularState = SKShapeNode(rect: CGRect(x: 0,y: 0,width: width,height: height));
        ButtonPressedState = SKShapeNode(rect: CGRect(x: 0,y: 0,width: width,height: height));
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
    func GetIsActive()->Bool
    {
        return self.IsActive;
    }
    func SetIsActive(value:Bool)
    {
        IsActive = value;
        if(IsActive)
        {
            ButtonPressedState.alpha = 1;
            ButtonRegularState.alpha = 0;
        }
        else
        {
            ButtonPressedState.alpha = 0;
            ButtonRegularState.alpha = 1;
        }
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
        return self.position.x ;
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
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first!;
        let point:CGPoint = touch.locationInNode(self);
        if(ButtonRegularState.containsPoint(point))
        {
            SetIsActive(!IsActive);
            onPressCode!();
        }
    }

}
