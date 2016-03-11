//
//  GameScene.swift
//  PTOD
//
//  Created by Andrew Turley on 3/10/16.
//  Copyright (c) 2016 Polturonduken. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let sprite = SKSpriteNode(imageNamed:"Orangutan")
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Welcome to the wonderful world of Oranguraton"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        
        sprite.position.x = 100
        sprite.position.y = 100
        
        self.addChild(sprite)
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            sprite.position.x = location.x
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
