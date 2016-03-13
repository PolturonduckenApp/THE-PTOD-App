//
//  GameScene.swift
//  PTOD
//
//  Created by Andrew Turley & the FFroy on 3/11/16.
//  Copyright (c) 2016 Polturonduken. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let orangutan = SKSpriteNode(imageNamed: "Orangutan")
    var soldier = SKSpriteNode(imageNamed: "Soldier1")
    var count = 0
    var targetLocation : CGPoint!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    let orangutanCategory : UInt32 = 0x1 << 0
    let soldierCategory : UInt32 = 0x1 << 1
    let worldName = SKLabelNode(fontNamed:"Chalkduster")
    
    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        worldName.text = "Tropical Oranguratta"
        worldName.fontSize = 35
        worldName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        orangutan.xScale = 0.5
        orangutan.yScale = 0.5
        
        orangutan.position.x = 102
        orangutan.position.y = 100
        
        orangutan.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        orangutan.physicsBody!.dynamic = false
        
        soldier.position.x = 500
        soldier.position.y = 100
        soldier.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        soldier.physicsBody!.dynamic = true
        
        orangutan.physicsBody!.categoryBitMask = orangutanCategory
        orangutan.physicsBody!.contactTestBitMask = soldierCategory
        orangutan.physicsBody!.collisionBitMask = soldierCategory
        
        soldier.physicsBody?.categoryBitMask = soldierCategory
        soldier.physicsBody?.contactTestBitMask = orangutanCategory
        soldier.physicsBody?.collisionBitMask = orangutanCategory
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        targetLocation = orangutan.position
        
        self.addChild(soldier)
        self.addChild(orangutan)
        self.addChild(worldName)
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
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("CONTACT")
    }
   
    override func update(currentTime: CFTimeInterval) {
        if worldName.alpha > 0 {
            worldName.alpha -= 0.03
        }
        
        if count % 10 == 0 {
            soldier.texture = SKTexture(imageNamed: "Soldier2")
        }
        else if count % 5 == 0{
            soldier.texture = SKTexture(imageNamed: "Soldier1")
        }
        
        soldier.position.y -= 10
        if soldier.position.y < 0 {
            soldier.position.y = screenSize.height + soldier.size.height
            soldier.position.x = CGFloat(arc4random_uniform(UInt32(screenWidth!)))
        }
        count++
        
        
        if orangutan.position.x + 7 < targetLocation.x {
            orangutan.position.x += 7
        }
        else if orangutan.position.x - 7 > targetLocation.x {
            orangutan.position.x -= 7
        }
    }
}
