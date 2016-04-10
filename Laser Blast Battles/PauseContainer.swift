//
//  PauseContainer.swift
//  Laser Blast Battles
//
//  Created by Doug McGill on 2016-04-09.
//  Copyright © 2016 Swift. All rights reserved.
//

import SpriteKit

class PauseContainer:SKNode
{
    var CloseButton:Button = Button (text:"Play Game");
    var QuitButton:Button = Button(text:"Quit");
    var Container:SKShapeNode?;
    let PauseLabel = SKLabelNode(fontNamed: "Chalkduster");
    init(width:CGFloat, height:CGFloat)
    {
        super.init();
        Container = SKShapeNode(rect: CGRect(x: 0,y: 0,width: width, height: height));
        Container?.fillColor = UIColor.grayColor()
        
        CloseButton.SetPosition(CGPointMake((width - CloseButton.GetWidth()) / 2,height / 2));
        QuitButton.SetPosition(CGPointMake(CloseButton.GetX(),CloseButton.GetY() - QuitButton.GetHeight() - 35));
        PauseLabel.position = CGPointMake(width/2,height - 200);
        PauseLabel.fontSize = 45;
        PauseLabel.text = "Paused";
        PauseLabel.fontColor = UIColor.blackColor();
        addChild(Container!);
        addChild(CloseButton);
        addChild(QuitButton);
        addChild(PauseLabel);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        CloseButton.touchesMoved(touches, withEvent: event);
        QuitButton.touchesMoved(touches, withEvent: event);
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        CloseButton.touchesEnded(touches, withEvent: event);
        QuitButton.touchesEnded(touches, withEvent: event);
    }
}
