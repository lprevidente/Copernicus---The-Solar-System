/*:
 Costruiamo la terra
 
 Richiamare il codice scritto prima
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import ARKit

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func createParentEarth() {
    proxy?.send(MessageFromContentsToLiveView.createParentEarth.playgroundValue)
}

func createEarthWithTexturesAndRotation() {
    proxy?.send(MessageFromContentsToLiveView.createEarthWithTexturesAndRotation.playgroundValue)
}

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
//#-code-completion(identifier, show, createEarthWithTexturesAndRotation(), createParentEarth())
//#-end-hidden-code
createSun(radius: 0.35, position: SCNVector3(0,0,-1))
setTextureToSun()
setSpeedRotationToSun(speedRotation: 8)
//#-editable-code

//#-end-editable-code
