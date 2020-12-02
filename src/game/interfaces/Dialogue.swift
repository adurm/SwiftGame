
import SpriteKit

// The dialogue with NPC interface
class Dialogue : SKNode {
    
    let box: SKSpriteNode = SKSpriteNode(imageNamed: "DialogueBox")
    // The words the person is saying
    var talkerChat: SKLabelNode = SKLabelNode(text: "")
    // The name of who is saying it
    var talkerName: SKLabelNode = SKLabelNode(text: "")
    
    override init() {
        super.init()
        initBox()
        initTalkerChat()
        initTalkerName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initBox() {
        box.zPosition = 5
        box.scaleTo(screenWidthPercentage: 0.6)
        box.isHidden = true
        addChild(box)
    }
    
    func initTalkerChat() {
        talkerChat.zPosition = 6
        talkerChat.fontColor = .black
        talkerChat.fontSize = 16
        talkerChat.fontName = "AvenirNext-Bold"
        box.addChild(talkerChat)
    }
    
    func initTalkerName() {
        talkerName.zPosition = 6
        talkerName.fontColor = .blue
        talkerName.fontSize = 14
        talkerName.fontName = "AvenirNext-Bold"
        talkerName.position.y = talkerChat.position.y + 40
        box.addChild(talkerName)
    }
    
    func toggle() {
        box.isHidden = !box.isHidden
    }
    
    func setText(text: String) {
        talkerChat.text = text
    }
    
    func setName(name: String) {
        talkerName.text = name
    }
    
}
