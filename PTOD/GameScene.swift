//
//  GameScene.swift
//  PTOD
//
//  Created by Andrew Turley & the FFroy on 3/11/16.
//  Copyright (c) 2016 Polturonduken. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var orangutan = SKSpriteNode(imageNamed: "Orangutan")
    var soldier : [SKSpriteNode] = []
    var count = 0
    var targetLocation : CGPoint!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    let orangutanCategory : UInt32 = 0x1 << 0
    let soldierCategory : UInt32 = 0x1 << 1
    let worldName = SKLabelNode(fontNamed:"Chalkduster")
    var healthLeft = 100
    var moveRight = false
    
    var healthBar = SKSpriteNode(color:SKColor .yellowColor(), size: CGSize(width: 600, height: 30))
    
    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        healthBar.position = CGPointMake(self.frame.size.width / 3, self.frame.size.height / 1.05)
        healthBar.anchorPoint = CGPointMake(0.0, 0.5)
        healthBar.zPosition = 4
        
        worldName.text = "Level 1: Tropical Kkjuy"
        worldName.fontSize = 35
        worldName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        orangutan.xScale = 0.2
        orangutan.yScale = 0.2
        
        orangutan.position.x = 100
        orangutan.position.y = 300
        
        orangutan.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        orangutan.physicsBody!.dynamic = false
        
        orangutan.physicsBody!.categoryBitMask = orangutanCategory
        orangutan.physicsBody!.contactTestBitMask = soldierCategory
        orangutan.physicsBody!.collisionBitMask = soldierCategory
        
        for var i in 0..<5 {
            soldier.append(SKSpriteNode(imageNamed: "Vietcong"))
            soldier[i].position.x = 100 * CGFloat(i)
            soldier[i].position.y = 100 * CGFloat(i)
            soldier[i].physicsBody = SKPhysicsBody(circleOfRadius: 50)
            soldier[i].physicsBody!.dynamic = true
            soldier[i].xScale = 0.3
            soldier[i].yScale = 0.3
            
            soldier[i].physicsBody?.categoryBitMask = soldierCategory
            soldier[i].physicsBody?.contactTestBitMask = orangutanCategory
            soldier[i].physicsBody?.collisionBitMask = orangutanCategory
            
            self.addChild(soldier[i])
        }
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        targetLocation = orangutan.position
        
        self.addChild(worldName)
        self.addChild(orangutan)
        self.addChild(healthBar)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location).name == "LevelOneButton" {
                let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
                
                let levelOne = LevelOne(size: scene!.size)
                levelOne.scaleMode = .AspectFill
                
                scene?.view?.presentScene(levelOne, transition: transition)
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        healthLeft -= 1
        healthBar.removeFromParent()
        healthBar = SKSpriteNode(color:SKColor .redColor(), size: CGSize(width: healthLeft * 6, height: 30))
        self.addChild(healthBar)
        healthBar.position = CGPointMake(self.frame.size.width / 3, self.frame.size.height / 1.05)
        healthBar.anchorPoint = CGPointMake(0.0, 0.5)
        healthBar.zPosition = 4
        if healthLeft == 0 {
            gameOver()
        }
    }
    
    func gameOver() {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        if worldName.alpha > 0 {
            worldName.alpha -= 0.03
        }
        
        for var i in 0..<5 {
            if count % 10 == 0 {
                soldier[i].texture = SKTexture(imageNamed: "Vietcong")
            }
            else if count % 5 == 0{
                soldier[i].texture = SKTexture(imageNamed: "Vietcong")
            }
            
            soldier[i].position.y -= 10
            if soldier[i].position.y < 0 {
                soldier[i].position.y = screenSize.height + soldier[i].size.height
                soldier[i].position.x = CGFloat(arc4random_uniform(UInt32(screenWidth!)))
            }
        }
        count += 1
        
        
        if orangutan.position.x + 7 < screenWidth && moveRight {
            orangutan.position.x += 7
        }
        else if orangutan.position.x - 7 > 0 && !moveRight {
            orangutan.position.x -= 7
        }
        else if orangutan.position.x + 7 > screenWidth {
            moveRight = false
        }
        else if orangutan.position.x - 7 < 0 {
            moveRight = true
        }
    }
}
