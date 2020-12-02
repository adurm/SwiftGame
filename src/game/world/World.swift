
import SpriteKit

// Class world contains all of the SKTileMapNodes
class World {
    
    let world : [[SKTileMapNode]]
    let tileSize : CGSize
    
    init(game: SKScene) {
        
        // Create empty world and array of map names to put in
        let scale : CGFloat = 1
        let array = ["GroundFloor", "FirstFloor", "TopFloor", "BottomFloor"]
        var world : [[SKTileMapNode]] = []
        
        // Initialise map and it's submaps, and put it into world
        for i in 0 ..< array.count {
            world.append([])
            world[i].append(game.childNode(withName: "\(array[i])1") as! SKTileMapNode)
            world[i].append(game.childNode(withName: "\(array[i])2") as! SKTileMapNode)
            // Initialise maps
            for submap in world[i]{
                submap.zPosition = 1
                submap.anchorPoint = CGPoint.zero
                submap.setScale(scale)
                submap.isHidden = true
                submap.isPaused = true
            }
        }
        
        tileSize = CGSize(width: world[0][0].tileSize.width * scale,
               height: world[0][0].tileSize.height * scale)
        self.world = world
    }
    
}
