
import SpriteKit

// Player Mover class is responsible for moving the player
class PlayerMover {
    
    let player : Player
    let joystick : Joystick
    let map : [[SKTileMapNode]]
    let tileSize : CGSize
    let interaction : Interaction
    let inventory : Inventory
    
    init(game: GameScene) {
        player = game.player
        joystick = game.interface.joystick
        map = game.world.world
        tileSize = game.world.tileSize
        inventory = game.interface.inventory
        interaction = Interaction(game: game)
    }
    
    /*
     The method that calls all other methods involved in moving the player
     */
    func movePlayer(touchLocation: CGPoint) {
        joystick.moveJoystick(touchLocation: touchLocation)
        player.animate(direction: direction())
        checkCollisions()
        interaction.checkInteractions()
    }
    
    /*
     Check where the player is about to move and stop it from moving
     if it is colliding with a wall or object
     */
    func checkCollisions() {
        let xMove = (direction().dx / joystick.radius) * player.playerSpeed
        let yMove = (direction().dy / joystick.radius) * player.playerSpeed
        let collision = Collision(bounds: player.bounds,
                                  tileSize: tileSize,
                                  currentMap: map[interaction.mapChanger.currentMapIndex])
        // If not colliding in x or y axis, move the player, else do nothing
        !collision.moveX(xMove: xMove) ? player.position.x += xMove : nil
        !collision.moveY(yMove: yMove) ? player.position.y += yMove : nil
        player.bounds.position = player.position
    }
    
    func direction() -> CGVector {
        return joystick.vectorBetween(point1: joystick.handle.position,
                                      point2: joystick.base.position)
    }
    
}
