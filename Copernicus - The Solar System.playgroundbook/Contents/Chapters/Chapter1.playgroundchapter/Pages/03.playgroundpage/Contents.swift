/*:
 # **Now it's turn of Earth**
 
 And our Earth? Well, it continues to play a central role in the system.
 
 All planets rotate around the centre of earth's orbit, that is the `centre` of Solar System.
 
 The Earth has a `motion of revolutions` around the Sun, or rather around the centre of his orbit and, also a `motion around its axis`.
 
 The steps to follow are:
 1. **Create a reference** to the centre of orbit, for our simplicity, is the centre of the sun.
 2. **Create the Earth** and put it on movements as you've made before.
 
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import ARKit

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func createReference() {
    proxy?.send(MessageFromContentsToLiveView.createParentEarth.playgroundValue)
}

func createEarth() {
    proxy?.send(MessageFromContentsToLiveView.createEarth.playgroundValue)
}
// Handle messages from the live view.
class Listener: PlaygroundRemoteLiveViewProxyDelegate {
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy,
                             received message: PlaygroundValue) {
        guard let liveViewMessage = MessageFromLiveViewToContents(playgroundValue: message) else { return }
        switch liveViewMessage {
        case .succeeded:
            page.assessmentStatus = .pass(message: "Oh! Finally we have the Earth [Next](@next)")
        default:
            break
        }
    }
    func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) { }
}

let listener = Listener()
proxy?.delegate = listener
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, createEarth(), createReference())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
