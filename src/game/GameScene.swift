
import SpriteKit

// The Game Scene is the main scene where the game will be displayed
class GameScene: SKScene {
    
    let gameCamera : SKCameraNode = SKCameraNode()
    var touchLocation: CGPoint = CGPoint.zero
    var touchHandler : TouchHandler!
    var playerMover : PlayerMover!
    let player: Player = Player()
    var interface : Interface!
    var world : World!
    
    /*
     Initialisation function
        - Parameter: the view to which this scene will be added to
     */
    override func didMove(to view: SKView) {
        initNodes()
        initCamera()
        initPositions()
        addChildren()
    }
    
    func initCamera() {
        camera = gameCamera
        // Constrain the camera to stay on top of the player
        gameCamera.constraints =
            [SKConstraint.distance(SKRange(constantValue:0),
                                   to: CGPoint(x: player.frame.midX,
                                               y: player.frame.midY),
                                   in: player)]
        gameCamera.addChild(interface)
    }
    
    func initNodes() {
        interface = Interface(game: self)
        world = World(game: self)
        playerMover = PlayerMover(game: self)
        touchHandler = TouchHandler(interface: interface)
    }
    
    func initPositions() {
        // Initialise player position to the desired starting position
        player.position = CGPoint(x: 15 * world.tileSize.width, y: 3 * world.tileSize.height)
        gameCamera.position = CGPoint(x: player.frame.midX, y: player.frame.midY)
    }
    
    func addChildren() {
        addChild(gameCamera)
        addChild(player)
    }
    
    /*
     This update method is called every frame
    */
    override func update(_ currentTime: CFTimeInterval) {
        // If the joystick is active, move the player accordingly
        interface.joystick.active ? playerMover.movePlayer(touchLocation: touchLocation) : nil
    }
    
    /*
     This method is called whenever the screen is touched
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Store the touch location as a global variable for all other classes to use
        touchLocation = touches.first!.location(in: gameCamera)
        // Handle the touch appropriately
        touchHandler.handleTouch(touchLocation: touchLocation)
    }
    
    /*
     This method is called whenever the screen touch is moved
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchLocation = touches.first!.location(in: gameCamera)
    }
    
    /*
     This method is called whenever the touch is released
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset the joystick
        interface.joystick.active ? interface.joystick.reset() : nil
    }
    
}
