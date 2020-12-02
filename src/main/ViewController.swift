
import UIKit
import SpriteKit

class ViewController: UIViewController {

    // Load the View and select the scene
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView: SKView = SKView()
        view.addSubview(skView)
        skView.frame = CGRect(x: 0.0, y: 0.0,
                              width: ScreenSize.width,
                              height: ScreenSize.height)
        if let scene = SKScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
        }
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.preferredFramesPerSecond = 30
    }
    
}
