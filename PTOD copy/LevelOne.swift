//
//  LevelOne.swift
//  PTOD
//
//  Created by Andrew Turley on 3/16/16.
//  Copyright © 2016 Polturonduken. All rights reserved.
//

import Foundation
import SpriteKit

var finishTime = 0

class LevelOne: SKScene, SKPhysicsContactDelegate {
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
    let timeLabel = SKLabelNode(fontNamed:"Chalkduster")
    var healthLeft = 3
    var hearts : [SKSpriteNode] = []
    var moveLeft = false
    var moveRight = false
    var timer = NSTimer()
    var countTime = 0
    
    var healthBar = SKSpriteNode(color:SKColor .yellowColor(), size: CGSize(width: 600, height: 30))
    
    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        worldName.text = "Level 1: Tropical Kkjuy"
        worldName.fontSize = 35
        worldName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        timeLabel.text = "0"
        timeLabel.fontSize = 35
        timeLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:screenHeight - 50)
        
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
            soldier[i].physicsBody = SKPhysicsBody(circleOfRadius: 70)
            soldier[i].physicsBody!.dynamic = true
            soldier[i].xScale = 0.3
            soldier[i].yScale = 0.3
            
            soldier[i].physicsBody?.categoryBitMask = soldierCategory
            soldier[i].physicsBody?.contactTestBitMask = orangutanCategory
            soldier[i].physicsBody?.collisionBitMask = orangutanCategory
            
            self.addChild(soldier[i])
        }
        
        hearts.append(SKSpriteNode(imageNamed: "heart"))
        hearts[0].position.x = 50
        hearts[0].position.y = screenHeight - 80
        hearts[0].xScale = 0.1
        hearts[0].yScale = 0.1
        hearts.append(SKSpriteNode(imageNamed: "heart"))
        hearts[1].position.x = 150
        hearts[1].position.y = screenHeight - 80
        hearts[1].xScale = 0.1
        hearts[1].yScale = 0.1
        hearts.append(SKSpriteNode(imageNamed: "heart"))
        hearts[2].position.x = 250
        hearts[2].position.y = screenHeight - 80
        hearts[2].xScale = 0.1
        hearts[2].yScale = 0.1
        
        targetLocation = orangutan.position
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        
        self.addChild(worldName)
        self.addChild(timeLabel)
        self.addChild(orangutan)
        self.addChild(hearts[0])
        self.addChild(hearts[1])
        self.addChild(hearts[2])
    }
    
    func updateTimer() {
        countTime = countTime + 1
        timeLabel.text = "Time: \(countTime)"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            targetLocation = touch.locationInNode(self)
            if targetLocation.x < screenWidth / 2 {
                moveLeft = true
                moveRight = false
            }
            else {
                moveRight = true
                moveLeft = false
            }
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            targetLocation = touch.locationInNode(self)
            if targetLocation.x < screenWidth / 2 {
                moveLeft = true
                moveRight = false
            }
            else {
                moveRight = true
                moveLeft = false
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        moveLeft = false
        moveRight = false
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        healthLeft = healthLeft - 1
        hearts[healthLeft].alpha = 0
        
        if healthLeft <= 0 {
            gameOver()
        }
    }
    
    func gameOver() {
        finishTime = countTime
        let transition = SKTransition.revealWithDirection(.Down, duration: 1.0)
        
        let gameOver = GameOver(size: scene!.size)
        gameOver.scaleMode = .AspectFill
        
        scene?.view?.presentScene(gameOver, transition: transition)
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
        
        
        if moveRight == true && orangutan.position.x < screenWidth {
            orangutan.position.x += 7
        }
        else if moveLeft == true && orangutan.position.x > 0 {
            orangutan.position.x -= 7
        }
    }
}
