
import SpriteKit

// Class Collision deals with detecting collisions between the player and other objects or walls
class Collision {
    
    let bounds : SKShapeNode
    let tileSize : CGSize
    let currentMap : [SKTileMapNode]
    // The background tiles that the player is allowed to step on without restricting movement
    let allowedBackground : [String] = ["Floor", "Grass", "StairFloor",
                                   "LadderFloor", "SecretPath1",
                                   "SecretPath2", "LockedDoorEntrance"]
    // The foreground tiles that the player is allowed to step on without restricting movement
    let allowedForeground : [String] = ["LockedDoor", "NPC"]
    
    init(bounds: SKShapeNode, tileSize : CGSize,
         currentMap: [SKTileMapNode]) {
        self.bounds = bounds
        self.tileSize = tileSize
        self.currentMap = currentMap
    }
    
    /*
     Check the x-axis direction
     */
    func moveX(xMove: CGFloat) -> Bool {
        // Look at the tiles above and below the player
        let y1 = getTile(at: bounds.frame.maxY/tileSize.height)
        let y2 = getTile(at: bounds.frame.minY/tileSize.height)
        var newX : Int
        // Attempt to move left or right according to the direction of player movement
        xMove > 0 ?
            (newX = getTile(at: (bounds.frame.maxX + xMove) / tileSize.width)) :
            (newX = getTile(at: (bounds.frame.minX + xMove) / tileSize.width))
        // Return true or false if there is a collision
        return (collision(x: newX, y: y1) || collision(x: newX, y: y2))
    }
    
    /*
     Check the y-axis direction
     */
    func moveY(yMove: CGFloat) -> Bool {
        let x1 = getTile(at: bounds.frame.maxX/tileSize.width)
        let x2 = getTile(at: bounds.frame.minX/tileSize.width)
        var newY : Int
        yMove > 0 ?
            (newY = getTile(at: (bounds.frame.maxY + yMove) / tileSize.height)) :
            (newY = getTile(at: (bounds.frame.minY + yMove) / tileSize.height))
        return (collision(x: x1, y: newY) || collision(x: x2, y: newY))
    }
    
    // Find a specific tile's coordinates from the location it is on the screen
    func getTile(at: CGFloat) -> Int {
        var new = at
        new < 0 ? new -= 1 : nil
        return Int (new)
    }
    
    // Return true if there is a collision with either the background (walls) or foreground (solid objects)
    func collision(x: Int, y: Int) -> Bool {
        return collisionWithBackground(x: x, y: y)
            || collisionWithForeground(x: x, y: y)
    }
    
    func collisionWithBackground(x: Int, y: Int) -> Bool {
        if let tile = currentMap[0].tileDefinition(atColumn: x, row: y) {
            return !allowedBackground.contains(tile.name!)
        }
        return true
    }
    
    func collisionWithForeground(x: Int, y: Int) -> Bool {
        if let tile = currentMap[1].tileDefinition(atColumn: x, row: y) {
            return allowedForeground.contains(tile.name!)
        }
        return false
    }
    
}
