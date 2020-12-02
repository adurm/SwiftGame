
import SpriteKit

// Class Interaction deals with interacting with objects in the game
class Interaction {
    
    let game : GameScene
    let world : [[SKTileMapNode]]
    let mapChanger : MapChanger
    let inventory : Inventory
    let stairs : [String] = ["StairFloor", "LadderFloor",
                            "SecretPath1", "SecretPath2"]
    let doors : [String] = ["LockedDoorEntrance"]
    let items : [String] = ["Poison", "FishFood", "Key",
                            "Spanner", "Hammer", "Screwdriver"]
    let npcs : [String] = ["NPC", "Bed_01"]
    var dialogues : [Dialogue] = []
    var taken : [String] = []
    var x: Int = 0
    var y: Int = 0
    var map: Int = 0
    
    public static var npcDialogue: Int = 1
    
    init(game: GameScene){
        self.game = game
        world = game.world.world
        inventory = game.interface.inventory
        mapChanger = MapChanger(game: game)
    }
    
    func checkInteractions() {
        // Get map and location of player
        map = mapChanger.currentMapIndex
        x = getTile(at: game.player.bounds.frame.midX / game.world.tileSize.width)
        y = getTile(at: game.player.bounds.frame.midY / game.world.tileSize.height)
        // Interact
        interactWithBackground()
        interactWithForeground()
    }
    
    func interactWithBackground() {
        if let tile = world[map][0].tileDefinition(atColumn: x, row: y) {
            let name = tile.name!
            if stairs.contains(name) {
                interactWithStairs(name: name)
            } else if doors.contains(name) {
                interactWithDoor(name: name)
            }
        }
    }
    
    // Interact with stairs by going up or down
    func interactWithStairs(name: String) {
        if name == "StairFloor" || name == "LadderFloor"{
            mapChanger.interactWithStairs(object: name)
        } else if name == "SecretPath1" {
            mapChanger.interactWithSecretPath(index: 1)
        } else if name == "SecretPath2" {
            mapChanger.interactWithSecretPath(index: 2)
        }
    }
    
    // The locked door can only be opened if the player has the key
    func interactWithDoor(name: String){
        if name == "LockedDoorEntrance" {
            if let tile = world[map][1].tileDefinition(atColumn: x+1, row: y) {
            if inventory.itemNames.contains("Key")
                && game.player.currentAnimation == 1 {
                tile.name = "LockedDoorOpen"
                tile.textures.removeAll()
                tile.textures.append(SKTexture(imageNamed: "LockedDoorOpen"))
                }
            }
        }
    }
    
    
    func interactWithForeground() {
        
        // ITEMS AND FURNITURE
        if let tile = world[map][1].tileDefinition(atColumn: x, row: y) {
            let name = tile.name!
            if items.contains(name) && !taken.contains(name) {
                interactWithItem(name: name)
            } else if tile.name == "FrontDoor" {
                tile.textures.removeAll()
                tile.textures.append(SKTexture(imageNamed: "FrontDoorOpen"))
            }
        }
        // NPCs
        else if let tile = world[map][1].tileDefinition(atColumn: x, row: y+1) {
            let name = tile.name!
            if npcs.contains(name) && game.player.currentAnimation == 2 {
                interactWithNPC(name: name)
            }
        }
    }
    
    // Chat with the NPC
    func interactWithNPC(name: String) {
        
        let sentences : [String] = getSentencesFromFile(name: "\(name)\(Interaction.npcDialogue)")
        createDialogue(sentences: sentences)
        createDialogueInterface()
    }
    
    // Load in the NPC chat
    func getSentencesFromFile(name: String) -> [String] {
        do {
            return try String(contentsOfFile: Bundle.main.path(forResource: name, ofType: "txt")!).components(separatedBy: .newlines)
        } catch {
        }
        return []
    }
    
    func createDialogue(sentences: [String]) {
        for i in 0..<sentences.count - 1 {
            let name = sentences[i].components(separatedBy: " ").first!
            let chat = sentences[i].components(separatedBy: " ").dropFirst().joined(separator: " ")
            let dialogue = Dialogue()
            dialogue.setName(name: name)
            dialogue.setText(text: chat)
            dialogues.append(dialogue)
        }
    }
    
    func createDialogueInterface() {
        dialogues[0].toggle()
        game.interface.joystick.reset()
        game.interface.createDialogue(dialogues: dialogues)
        dialogues.removeAll()
    }
    
    func interactWithItem(name: String) {
        inventory.add(item: name)
        world[mapChanger.currentMapIndex][1].setTileGroup(nil, forColumn: x, row: y)
        taken.append(name)
    }
    
    func getTile(at: CGFloat) -> Int {
        var new = at
        new < 0 ? new -= 1 : nil
        return Int (new)
    }
    
}
