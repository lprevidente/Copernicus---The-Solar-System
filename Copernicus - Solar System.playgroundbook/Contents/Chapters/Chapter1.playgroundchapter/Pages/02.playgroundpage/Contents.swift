/*:
 
 # **Start from the basis**
 
 Venturing in the `De revolutionibus orbium coelestium` (*On the Revolutions of the Heavenly Spheres*), published on 1543, some days before the death of the author, we can discover that the solar system referred to is `Heliocentric`: the center of everything is the Sun, it is fixed and it's 'near' the center of universe. (*Why near?*).
 
 So start to build the *our* solar system:
 
 1. You need to **Create the Sun**.
 2. What is a sun without anything? We know that is composed mainly of Hydrogen and Helium, so we need to put them on it. Put a **Texture** on the sun created.
 3. It isn't totally fixed, it rotates around its own axis. You have two ways to put it into motion. `Try to discover which are`.
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
            page.assessmentStatus = .pass(message: "Now we have a beautiful sun! [Go Next](@next) ")
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
//#-code-completion(identifier, show)
//#-end-hidden-code
createSun(radius:/*#-editable-code*/0.35/*#-end-editable-code*/, position: SCNVector3(/*#-editable-code 0*/0/*#-end-editable-code*/,/*#-editable-code */0/*#-end-editable-code*/,/*#-editable-code -1*/-1/*#-end-editable-code*/))
//#-editable-code

//#-end-editable-code
