
import SpriteKit

// Class Map Changer deals with changing the map when stairs are used
class MapChanger {
    
    let world : [[SKTileMapNode]]
    let game : GameScene
    let player : Player
    let joystick : Joystick
    var currentMapIndex : Int
    
    init(game: GameScene) {
        self.game = game
        world = game.world.world
        player = game.player
        joystick = game.interface.joystick
        currentMapIndex = 0
        moveMap(toIndex: 0)
    }
    
    func interactWithStairs(object: String) {
        // Disable user interaction
        game.isUserInteractionEnabled = false
        // Blank the screen. This gives a good illusion of map transitioning
        game.run(SKAction.fadeOut(withDuration: 0.01))
        // Change floor according to which stairs are used
        if object == "StairFloor" {
            if currentMapIndex == 0 { // Ground floor stairs going up
                player.position = tileAt(x: 17, y: 14)
                moveMap(toIndex: 1)
            } else if currentMapIndex == 1 { // First floor stairs going down
                player.position = tileAt(x: 29, y: 26)
                moveMap(toIndex: 0)
            }
        } else if object == "LadderFloor" {
            if currentMapIndex == 0 { // Ground floor ladder going down
                player.position = tileAt(x: 23, y: 1)
                moveMap(toIndex: 3)
            } else if currentMapIndex == 1 { // First floor ladder going up
                player.position = tileAt(x: 3, y: 4)
                moveMap(toIndex: 2)
            } else if currentMapIndex == 2 { // Top floor ladder going down
                player.position = tileAt(x: 2, y: 11)
                moveMap(toIndex: 1)
            } else if currentMapIndex == 3 { // Bottom floor going up
                player.position = tileAt(x: 38, y: 20)
                moveMap(toIndex: 0)
            }
        }
        joystick.reset()
    }
    
    // Move the player onto the map
    func moveMap(toIndex: Int) {
        for submap in world[currentMapIndex] {
            submap.position = CGPoint(x: 3000, y: 3000)
            submap.isHidden = true
            submap.isPaused = true
        }
        currentMapIndex = toIndex
        for submap in world[currentMapIndex] {
            submap.position = CGPoint.zero
            submap.isHidden = false
            submap.isPaused = false
        }
        // Show the screen and allow user interaction again
        game.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 0.5)]))
        game.isUserInteractionEnabled = true
    }
    
    func tileAt(x: Int, y: Int) -> CGPoint {
        return CGPoint(x: CGFloat (x)*game.world.tileSize.width,
                       y: CGFloat (y)*game.world.tileSize.height)
    }
    
    func interactWithSecretPath(index: Int) {
        game.isUserInteractionEnabled = false
        game.run(SKAction.fadeOut(withDuration: 0.0))
        if index == 1 {
            player.position.x -= game.world.tileSize.width * 3
        } else if index == 2 {
            player.position.x += game.world.tileSize.width * 3
        }
        player.bounds.position = player.position
        joystick.reset()
        
        game.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 0.5)]))
        game.isUserInteractionEnabled = true
    }
    
}

