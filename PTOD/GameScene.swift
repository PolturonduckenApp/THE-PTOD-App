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
    var vietcong1 = SKSpriteNode(imageNamed: "Vietcong1")
    var vietcong2 = SKSpriteNode(imageNamed: "Vietcong2")
    var count = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Tropical Oranguratta"
        myLabel.fontSize = 35
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        orangutan.xScale = 0.5
        orangutan.yScale = 0.5
        
        orangutan.position.x = 102
        orangutan.position.y = 100
        
        vietcong1.position.x = 500
        vietcong1.position.y = 100
        
        self.addChild(vietcong1)
        self.addChild(orangutan)
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            orangutan.position.y = location.y - 20 //interesting...
            orangutan.position.x = location.x
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:10) //testing longer duration
            
            orangutan.runAction(SKAction.repeatActionForever(action))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if count % 13 == 0 {
            vietcong1.texture = SKTexture(imageNamed: "Orangutan") //gives it that small chance of friendly fire
        }
        if count % 10 == 0 {
            vietcong1.texture = SKTexture(imageNamed: "Vietcong2")
        }
        else if count % 5 == 0{
            vietcong1.texture = SKTexture(imageNamed: "Vietcong1")
        }
        count++
    }
}
