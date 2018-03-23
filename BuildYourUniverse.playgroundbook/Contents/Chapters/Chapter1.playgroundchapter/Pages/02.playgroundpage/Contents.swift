/*:
 
 Here there will be a breif introduction about the playground book
 
 ## **This is Big Bold**
 
 Normal
 
 `Corsivo`.
 
 **Bold**:
 
 *Simple bold*!
 
 
 
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import ARKit

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

//#-hidden-code
func createSun(radius: CGFloat, position: SCNVector3) {
    proxy?.send(MessageFromContentsToLiveView.createSun(radius: radius, position: position).playgroundValue)
}

func setTexture() {
    proxy?.send(MessageFromContentsToLiveView.setTexture.playgroundValue)
}

func setSpeedRotation(speedRotation: Int) {
    proxy?.send(MessageFromContentsToLiveView.setSpeedRotation(speedRotation: speedRotation).playgroundValue)
}

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, createSun(radius:position:), setSpeedRotation(speedRotation:), setTexture(), SCNVector3(x:y:z:))
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
