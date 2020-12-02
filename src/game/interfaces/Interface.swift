
import SpriteKit

// The Interface contains all the on screen interfaces
class Interface : SKNode {
    
    let game : GameScene
    let progress : Progress = Progress()
    let inventory : Inventory = Inventory()
    let menu : Menu = Menu()
    let joystick : Joystick
    var dialogues : [Dialogue] = []
 
    init(game: GameScene) {
        self.game = game
        joystick = Joystick(player: game.player)
        super.init()
        initPositions()
        addChildren()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Initialise the position of all the interfaces
     */
    func initPositions() {
        initProgressPosition()
        initInventoryPosition()
        initMenuPosition()
        initJoystickPosition()
    }
    
    func initProgressPosition() {
        progress.button.position = CGPoint(x: game.frame.width * 0.42,
                                           y: game.frame.height * 0.4)
        progress.diary.position = CGPoint(x: -game.frame.width * 0.02,
                                          y: 0)
    }
    
    func initInventoryPosition() {
        inventory.button.position = CGPoint(x: game.frame.width * 0.42,
                                            y: -game.frame.height * 0.4)
        inventory.panel.position = CGPoint(x: -game.frame.width * 0.28,
                                           y: -game.frame.height * 0.4)
    }
    
    func initMenuPosition() {
        menu.icon.position = CGPoint(x: -game.frame.width * 0.42,
                                     y: game.frame.height * 0.4)
        menu.soundOn.position = CGPoint(x: -game.frame.width * 0.42,
                                        y: menu.icon.position.y - 50)
        menu.soundOff.position = menu.soundOn.position
        menu.quit.position = CGPoint(x: -game.frame.width * 0.42,
                                     y: menu.icon.position.y - 100)
    }
    
    func initJoystickPosition() {
        joystick.base.position = CGPoint(x: -game.frame.width * 0.4,
                                         y: -game.frame.height * 0.3)
        joystick.handle.position = joystick.base.position
    }
    
    
    func createDialogue(dialogues: [Dialogue]) {
        for dialogue in dialogues {
            dialogue.box.position = CGPoint(x: 0,
                                            y: -game.frame.height * 0.3)
            self.dialogues.append(dialogue)
            addChild(dialogue)
        }
    }

    func addChildren() {
        addChild(menu)
        addChild(progress)
        addChild(inventory)
        addChild(joystick.base)
        addChild(joystick.handle)
    }
    
}
