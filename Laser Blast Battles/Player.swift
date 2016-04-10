//
//  Player.swift
//  Laser Blast Battles
//
//  Created by Doug McGill on 2016-04-09.
//  Copyright © 2016 Swift. All rights reserved.
//

import SpriteKit

class Player:SKNode
{
    let PlayerImage:SKShapeNode = SKShapeNode(rect:CGRect(x: 0, y: 0, width: 60, height: 60));
    var Power:Float = 50;
    let PowerAmount:Float = 1;
    var PowerScale:Float = 1;
    init(color:UIColor)
    {
        super.init();
        PlayerImage.fillColor = color;
        addChild(PlayerImage);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func AddPower()
    {
        Power += (PowerAmount * PowerScale);
    }
    func GetPower()->Float
    {
        return Power;
    }
    func SetPowerScale(value:Float)
    {
        PowerScale = value;
    }
}
