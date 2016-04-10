//
//  ConfirmationContainer.swift
//  Laser Blast Battles
//
//  Created by Doug McGill on 2016-04-09.
//  Copyright © 2016 Swift. All rights reserved.
//

import SpriteKit

class ConfirmationContainer:SKNode
{
    let YesButton:Button = Button(text:"Yes");
    let NoButton:Button = Button(text:"No");
    
    var Container:SKShapeNode?;
    let ConfirmationLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster");
    
    init(width:CGFloat,height:CGFloat)
    {
        super.init();
        Container = SKShapeNode(rect:CGRect(x: 0, y: 0, width: width, height: height));
        Container?.fillColor = UIColor.grayColor();
        YesButton.SetPosition(CGPointMake(width/3 - (YesButton.GetWidth() / 2), height / 2));
        NoButton.SetPosition(CGPointMake((width/3)*2 - (NoButton.GetWidth() / 2), YesButton.GetY()));
        ConfirmationLabel.text = "Are you sure you want to quit?";
        ConfirmationLabel.fontSize = 45;
        ConfirmationLabel.fontColor = UIColor.blackColor();
        ConfirmationLabel.position = CGPointMake(width/2,height - 200);
        
        addChild(Container!);
        addChild(ConfirmationLabel);
        addChild(YesButton);
        addChild(NoButton);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        YesButton.touchesEnded(touches, withEvent: event);
        NoButton.touchesEnded(touches, withEvent: event);
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        YesButton.touchesMoved(touches, withEvent: event);
        NoButton.touchesMoved(touches, withEvent: event);
    }
}
