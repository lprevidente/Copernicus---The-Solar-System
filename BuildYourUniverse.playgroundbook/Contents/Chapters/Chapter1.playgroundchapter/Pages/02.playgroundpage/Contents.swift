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

func createSun(radius: CGFloat, position: SCNVector3) {
    proxy?.send(MessageFromContentsToLiveView.createSun(radius: radius, position: position).playgroundValue)
}

func setTextureToSun() {
    proxy?.send(MessageFromContentsToLiveView.setTextureToSun.playgroundValue)
}

func setSpeedRotationToSun(speedRotation: Int) {
    proxy?.send(MessageFromContentsToLiveView.setSpeedRotationToSun(speedRotation: speedRotation).playgroundValue)
}

// Handle messages from the live view.
class Listener: PlaygroundRemoteLiveViewProxyDelegate {
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy,
                             received message: PlaygroundValue) {
        guard let liveViewMessage = MessageFromLiveViewToContents(playgroundValue: message) else { return }
        switch liveViewMessage {
        case .succeeded:
            page.assessmentStatus = .pass(message: "You Did it!")
        default:
            break
        }
    }
    func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) { }
}

let listener = Listener()
proxy?.delegate = listener
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, setSpeedRotationToSun(speedRotation:), setTextureToSun())
//#-code-completion(identifier, show, 0.35, 0)
//#-end-hidden-code
createSun(radius:/*#-editable-code 0.35*//*#-end-editable-code*/, position: SCNVector3(/*#-editable-code 0*/ /*#-end-editable-code*/,/*#-editable-code 0*/ /*#-end-editable-code*/,/*#-editable-code -1*/ /*#-end-editable-code*/))
//#-editable-code

//#-end-editable-code
