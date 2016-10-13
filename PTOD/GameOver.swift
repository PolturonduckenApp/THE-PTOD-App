//
//  GameOver.swift
//  PTOD
//
//  Created by Andrew Turley on 10/12/16.
//  Copyright © 2016 Polturonduken. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKScene {
    let gameOver = SKLabelNode(fontNamed:"Chalkduster")
    let time = SKLabelNode(fontNamed:"Chalkduster")
    
    override func didMoveToView(view: SKView) {
        gameOver.text = "GAME OVER VIETCONG WON"
        gameOver.fontSize = 60
        gameOver.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        time.text = "Time: \(finishTime) seconds"
        time.fontSize = 60
        time.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 80)
        
        self.addChild(gameOver)
        self.addChild(time)
    }
}
