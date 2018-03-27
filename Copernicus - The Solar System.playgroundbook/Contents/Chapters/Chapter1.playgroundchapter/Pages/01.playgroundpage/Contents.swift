/*:
   # **A Bit of History**
 
 It was way back in 1543 when a polish astrologist, *Nicolaus Copernicus*, went against the geocentric theory of the period which saw the Earth as the centre of the universe.
 
 Although the heliocentric theory was conceived by a greek astronomist in 300 BC, Nicolaus was the first to provide a mathematical proof of it, subverting the concept on which people and scientists were rooted.
 
 Let's start our journey going back with a **time travel machine** in the XVI century, trying to walk down the same path that Nicolaus made during his studies.
 
Do you want to start? Just write down the right line of code and go.
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import Foundation

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func startTimeTravel() {
    proxy?.send(MessageFromContentsToLiveView.startTimeTravel.playgroundValue)
    page.assessmentStatus = .pass(message: "Well, then our journey shall begin. [Go](@next) ")
}
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, startTimeTravel())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
