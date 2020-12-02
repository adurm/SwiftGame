
import SpriteKit

// The game progress interface
class Progress : SKNode {
    
    let button : SKSpriteNode = SKSpriteNode(imageNamed: "QuestButton")
    // The diary is the interface that opens up and takes up the whole screen
    // where the game help text will be displayed
    let diary : SKSpriteNode = SKSpriteNode(imageNamed: "Scroll")
    let text : SKLabelNode = SKLabelNode(text: "Quest help text")
    
    override init() {
        super.init()
        initButton()
        initDiary()
        initText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initButton() {
        button.scaleTo(screenWidthPercentage: 0.1)
        button.zPosition = 3
        addChild(button)
    }
    
    func initDiary() {
        diary.zPosition = 5
        diary.scaleTo(screenWidthPercentage: 0.8)
        diary.yScale = 0.8
        diary.isHidden = true
        diary.isUserInteractionEnabled = false
        addChild(diary)
    }
    
    func initText() {
        text.zPosition = 6
        text.isUserInteractionEnabled = false
        text.fontColor = .black
        diary.addChild(text)
    }
    
    func toggle() {
        diary.isHidden = !diary.isHidden
    }
    
}
