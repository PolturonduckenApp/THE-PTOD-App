//
//  GameScene.swift
//  PTOD
//
//  Created by Andrew Turley & the FFroy on 3/11/16.
//  Copyright (c) 2016 Polturonduken. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let orangutan = SKSpriteNode(imageNamed: "Orangutan")
    var soldier = SKSpriteNode(imageNamed: "Soldier1")
    var count = 0
    var targetLocation : CGPoint!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    
    override func didMoveToView(view: SKView) {
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Tropical Oranguratta"
        myLabel.fontSize = 35
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        orangutan.xScale = 0.5
        orangutan.yScale = 0.5
        
        orangutan.position.x = 102
        orangutan.position.y = 100
        
        soldier.position.x = 500
        soldier.position.y = 100
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        targetLocation = orangutan.position
        
        self.addChild(soldier)
        self.addChild(orangutan)
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            targetLocation = touch.locationInNode(self)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            targetLocation = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if count % 10 == 0 {
            soldier.texture = SKTexture(imageNamed: "Soldier2")
        }
        else if count % 5 == 0{
            soldier.texture = SKTexture(imageNamed: "Soldier1")
        }
        
        soldier.position.y -= 10
        if soldier.position.y < 0 {
            soldier.position.y = screenSize.height + soldier.size.height
        }
        count++
        
        
        if orangutan.position.x + 5 < targetLocation.x {
            orangutan.position.x += 5
        }
        else if orangutan.position.x - 5 > targetLocation.x {
            orangutan.position.x -= 5
        }
    }
}
