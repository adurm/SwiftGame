
import SpriteKit

// Menu Interface
class Menu : SKNode {

    let icon : SKSpriteNode = SKSpriteNode(imageNamed: "MenuButton")
    let soundOn : SKSpriteNode = SKSpriteNode(imageNamed: "SoundOnButton")
    let soundOff : SKSpriteNode = SKSpriteNode(imageNamed: "SoundOffButton")
    let quit : SKSpriteNode = SKSpriteNode(imageNamed: "QuitButton")
    var sound : Bool = true
    
    override init() {
        super.init()
        // Initialise buttons
        for button in [icon, soundOn, soundOff, quit] {
            button.scaleTo(screenWidthPercentage: 0.08)
            button.zPosition = 3
            if button != icon {
                button.isHidden = true
            }
            addChild(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Open and close the menu
    func toggle() {
        sound ? (soundOn.isHidden = !soundOn.isHidden) : (soundOff.isHidden = !soundOff.isHidden)
        quit.isHidden = !quit.isHidden
    }
    
    // Check whether to display the sound on or sound off icon
    func toggleSound() {
        sound = !sound
        soundOn.isHidden = !soundOn.isHidden
        soundOff.isHidden = !soundOff.isHidden
    }
    
}
