
import SpriteKit

// Inventory interface
class Inventory : SKNode {
    
    let button : SKSpriteNode = SKSpriteNode(imageNamed: "InventoryButton")
    let panel : SKSpriteNode = SKSpriteNode(imageNamed: "Inventory")
    var items : [SKSpriteNode] = []
    var itemNames : [String] = []
    
    override init() {
        super.init()
        button.scaleTo(screenWidthPercentage: 0.1)
        button.zPosition = 3
        addChild(button)
        
        panel.zPosition = 5
        panel.isHidden = true
        panel.isUserInteractionEnabled = false
        panel.anchorPoint = CGPoint(x: 0, y: 0.5)
        addChild(panel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(item: String) {
        items.append(SKSpriteNode(imageNamed: item))
        itemNames.append(item)
        update()
    }
    
    // Update the items in the inventory whenever a new one is added
    func update() {
        removeAllChildren()
        addChild(button)
        addChild(panel)
        if items.count == 0 {
            return
        }
        // For each item in the inventory, draw it at a certain position
        for i in 0..<items.count {
            items[i].anchorPoint = CGPoint(x:0, y:0.5)
            items[i].size = CGSize(width: 60, height: 60)
            items[i].position = CGPoint(x: panel.position.x + 15 + CGFloat (70 * i),
                                        y: panel.position.y)
            items[i].zPosition = 6
            items[i].isHidden = panel.isHidden
            addChild(items[i])
        }
    }
    
    func toggle() {
        panel.isHidden = !panel.isHidden
        for item in items {
            item.isHidden = !item.isHidden
        }
    }
    
}
