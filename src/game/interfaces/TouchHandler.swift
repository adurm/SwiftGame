
import SpriteKit

// Touch Handler deals with the user input
class TouchHandler {
    
    let interface : Interface
    var touchLocation : CGPoint = CGPoint.zero
    
    init(interface: Interface) {
        self.interface = interface
    }
    
    /*
     Get the location of the touch on the screen and call the appropriate method to handle it
     */
    func handleTouch(touchLocation: CGPoint) {
        self.touchLocation = touchLocation
        
        handleMenuTouch()
        
        // Only allow dialogues to be clicked on if they are open
        if !interface.dialogues.isEmpty {
            if interface.dialogues[0].contains(touchLocation) {
                showNextDialogue()
            } else {
                return
            }
        } else {
            interface.removeAllChildren()
            interface.addChild(interface.menu)
            interface.addChild(interface.progress)
            interface.addChild(interface.inventory)
            interface.addChild(interface.joystick.base)
            interface.addChild(interface.joystick.handle)
        }
        
        //Handle progress button
        if interface.progress.button.contains(touchLocation) {
            interface.progress.toggle()
        }
        if !interface.progress.diary.isHidden {
            return
        }
        
        handleInventoryTouch()
        handleJoystickTouch()
    }
    
    func showNextDialogue() {
        //show the next dialogue page
        if interface.dialogues.count > 1 {
            interface.dialogues[1].toggle()
        } else {
            if Interaction.npcDialogue == 1 {
                Interaction.npcDialogue = 2
            }
        }
        interface.dialogues.removeFirst().toggle()
    }
    
    func handleInventoryTouch() {
        if interface.inventory.button.contains(touchLocation) {
            interface.inventory.toggle()
        }
    }
    
    func handleJoystickTouch(){
        if interface.joystick.handle.contains(touchLocation) {
            interface.joystick.activate()
        }
    }
    
    func handleMenuTouch() {
        if interface.menu.icon.contains(touchLocation){
            interface.menu.toggle()
        }
        if !interface.menu.quit.isHidden {
            if interface.menu.soundOn.contains(touchLocation) {
                interface.menu.toggleSound()
            }
        }
    }
    
}
