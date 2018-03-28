/*:
 # **Let's go to discover the Solar System**.
 
 Now you have all instruments and acknowledgements to **create** the Solar System.
 
 It has made of eight planets: `Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus and Neptune`. We add also `Pluto`, it was considered as a planet but now it's a *nano-planet*.
 
 Explore it all, try to catch the differences between them such as the colours, the velocity of rotation and the sizes.
 
 Our trip is not ended, remember the life is full of surprise. `Go and look for the one reserved for you.`
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import ARKit

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func createSolarSystem(){
    proxy?.send(MessageFromContentsToLiveView.createSolarSystem.playgroundValue)
}

// Handle messages from the live view.
class Listener: PlaygroundRemoteLiveViewProxyDelegate {
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy,
                             received message: PlaygroundValue) {
        guard let liveViewMessage = MessageFromLiveViewToContents(playgroundValue: message) else { return }
        switch liveViewMessage {
        case .succeeded:
            page.assessmentStatus = .pass(message: "You have completed the book. You are like Nicolaus ")
        default:
            break
        }
    }
    func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) { }
}

let listener = Listener()
proxy?.delegate = listener
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, createSolarSystem())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
