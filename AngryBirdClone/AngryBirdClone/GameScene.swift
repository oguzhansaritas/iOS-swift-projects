//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by OGUZHAN SARITAS.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box6 = SKSpriteNode()
    var box7 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    
    enum ColliderTeype:UInt32{
        case Bird = 1
        case Box = 2
    }
    var score = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        /*Get label node from scene and store it for use later
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position=CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: 100, height: 100)
        bird2.zPosition = 1
        self.addChild(bird2)
         */
        
        
        
        // Physics Body
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        // Bird
        
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/13)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        bird.physicsBody?.contactTestBitMask = ColliderTeype.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderTeype.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderTeype.Box.rawValue
        
        
        // Box
        let boxTexture = SKTexture(imageNamed: "blok1")
        let size = CGSize(width: boxTexture.size().width/5, height: boxTexture.size().height/5)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.2
        box1.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
      
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.2
        box2.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
      
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.2
        box3.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.2
        box4.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.2
        box5.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
        
        box6 = childNode(withName: "box6") as! SKSpriteNode
        box6.physicsBody = SKPhysicsBody(rectangleOf: size)
        box6.physicsBody?.isDynamic = true
        box6.physicsBody?.affectedByGravity = true
        box6.physicsBody?.allowsRotation = true
        box6.physicsBody?.mass = 0.2
        box6.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
        
        box7 = childNode(withName: "box7") as! SKSpriteNode
        box7.physicsBody = SKPhysicsBody(rectangleOf: size)
        box7.physicsBody?.isDynamic = true
        box7.physicsBody?.affectedByGravity = true
        box7.physicsBody?.allowsRotation = true
        box7.physicsBody?.mass = 0.2
        box7.physicsBody?.collisionBitMask = ColliderTeype.Bird.rawValue
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 50
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height/5)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderTeype.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderTeype.Bird.rawValue{
            print("contact")
            score += 1
            scoreLabel.text = String(score)
            
        }
            
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        bird.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
        bird.physicsBody?.affectedByGravity = true
         */
        if gameStarted == false{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    for node in touchNodes{
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    for node in touchNodes{
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false{
                    for node in touchNodes{
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird{
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y-originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
 
                            }
                        }
                    }
                }
            }
        }


    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let birdphysicsbody = bird.physicsBody{
            
            if birdphysicsbody.velocity.dx <= 0.1 && birdphysicsbody.velocity.dy <= 0.1 && birdphysicsbody.angularVelocity <= 0.1 && gameStarted == true{
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.zPosition = 1
                bird.position = originalPosition!
                gameStarted = false
            }
        }
    }
}
