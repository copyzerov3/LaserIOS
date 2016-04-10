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
    let PlayerImage:SKShapeNode = SKShapeNode(rect:CGRect(x: 0, y: 0, width: 60, height: 90));
    var Laser:SKShapeNode = SKShapeNode(rect:CGRect(x:0,y:0,width:1,height:60));
    //1 = left 0 = right;
    var direction:Int = 0;
    var Power:Float = 50;
    let PowerAmount:Float = 1;
    var PowerScale:Float = 1;
    var MaxLengthOfLaser:Float = 0;
    init(color:UIColor)
    {
        super.init();
        PlayerImage.fillColor = color;
        Laser.fillColor = color;
        addChild(PlayerImage);
        addChild(Laser);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func StartLaser()
    {
        UpdateLaser();
    }
    func AddPower() ->Float
    {
        Power += (PowerAmount * PowerScale);
        UpdateLaser();
        return (PowerAmount * PowerScale);
    }
    func LowerPower(value:Float)
    {
        Power -= value;
        UpdateLaser();
    }
    func GetPower()->Float
    {
        return Power;
    }
    func SetPowerScale(value:Float)
    {
        PowerScale = value;
    }
    private func UpdateLaser()
    {
        Laser.removeFromParent();
        let Scale:CGFloat = CGFloat(((Power / 100) * MaxLengthOfLaser));
        print("The max length of the laser is  \(MaxLengthOfLaser) and the Scale calculated is \(Scale)");
        Laser = SKShapeNode(rect: CGRect(x: 0, y: 0, width: Scale, height: 60));
        Laser.fillColor = PlayerImage.fillColor;
        if(direction == 0)
        {
            Laser.position.x = PlayerImage.frame.width;
        }
        else
        {
            Laser.position.x = -Laser.frame.width;
        }
        addChild(Laser);
    }
}
