
import SpriteKit

// Joystick is responsible for taking user input and moving the player
class Joystick {
    
    let handle: SKSpriteNode = SKSpriteNode(imageNamed: "JoystickHandle")
    let base: SKSpriteNode = SKSpriteNode(imageNamed: "JoystickBase")
    let radius : CGFloat
    var active : Bool
    let player : Player
    
    init(player: Player) {
        self.player =  player
        radius = base.frame.width / 2
        active = false
        base.zPosition = 3
        handle.zPosition = 4
    }
    
    /*
     Check if user is touching the joystick
     */
    func moveJoystick(touchLocation: CGPoint) {
        isTouchOnJoystick(touchLocation: touchLocation)
            ? handle.position = touchLocation
            : keepJoystickInBase(touchLocation: touchLocation)
    }
    
    /*
     When the user touches the joystick and moves
     their finger outside of the joystick base
     radius, this method will keep the joystick
     inside the base
     */
    func keepJoystickInBase(touchLocation: CGPoint) {
        let vector = vectorBetween(point1: touchLocation,
                                   point2: base.position)
        let angle = atan2(vector.dy, vector.dx)
        let xDist:CGFloat = sin(angle - 1.57079633) * radius
        let yDist:CGFloat = cos(angle - 1.57079633) * radius
        handle.position = CGPoint(x: base.position.x - xDist,
                                  y: base.position.y + yDist)
    }
    
    func activate() {
        active = true
    }
    
    func reset() {
        active = false
        // reposition the joystick handle to the base position
        handle.position = base.position
        // play the characters idle animation
        player.playAnimation(directionCode: 4)
    }
    
    func stop() {
        active = false
        handle.position = base.position
    }
    
    func isTouchOnJoystick(touchLocation: CGPoint) -> Bool {
        return distanceBetween(v1: touchLocation, v2: base.position) < radius
    }
    
    func distanceBetween(v1: CGPoint, v2: CGPoint) -> CGFloat {
        return sqrt(pow(v1.x-v2.x, 2) + pow(v1.y-v2.y, 2))
    }
    
    func vectorBetween(point1: CGPoint, point2: CGPoint) -> CGVector {
        return CGVector(dx: point1.x - point2.x, dy: point1.y - point2.y)
    }
    
}
