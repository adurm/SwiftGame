
import SpriteKit

// The player class
class Player : SKSpriteNode {
    
    let playerSpeed : CGFloat = 4
    var animationsArray: [[SKTexture]] = []
    var currentAnimation: Int = 4
    // Bounds is the rectangle that will be used to check for collision detection
    var bounds: SKShapeNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: SKTexture(imageNamed: "idle1"),
                   color: UIColor.white,
                   size: CGSize(width: 100,
                                height: 100))
        zPosition = 2
        anchorPoint = CGPoint.zero
        createAnimations()
        playAnimation(directionCode: currentAnimation)
        scaleTo(screenWidthPercentage: 0.1)
        bounds = SKShapeNode(rect: CGRect(x: frame.width / 3,
                                          y: frame.height / 5,
                                          width: frame.width / 3,
                                          height: frame.height / 4))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Initialise the different animations as an array of array of images
    func createAnimations() {
        let array = ["left", "right", "up", "down", "idle"]
        for i in 0..<array.count {
            animationsArray.append([])
            let atlas = SKTextureAtlas(named: "Player\(array[i])")
            for j in 1...atlas.textureNames.count {
                animationsArray[i].append(atlas.textureNamed("\(array[i])\(j)"))
            }
        }
    }
    
    // Find out which way the player is facing to determine the direction the player should be facing
    func animate(direction: CGVector) {
        let angle = ((-180 * atan2(direction.dy, direction.dx)) / CGFloat.pi) + 180
        if angle >= 315 || angle < 45 {
            animationDirection(directionCode: 0)
        } else if angle >= 135 && angle < 225 {
            animationDirection(directionCode: 1)
        } else if angle >= 45 && angle < 135 {
            animationDirection(directionCode: 2)
        } else if angle >= 225 && angle < 315 {
            animationDirection(directionCode: 3)
        } else {
            playAnimation(directionCode: 4)
        }
    }
    
    // Play the animation based on the direction they are facing
    func animationDirection(directionCode: Int) {
        if currentAnimation != directionCode {
            playAnimation(directionCode: directionCode)
        }
    }
    
    func playAnimation(directionCode: Int) {
        run(SKAction.repeatForever(
            SKAction.animate(with: animationsArray[directionCode],
                             timePerFrame: 0.04)))
        currentAnimation = directionCode
    }
    
}
