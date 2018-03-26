/*:
   # **A Bit of History**
 
 It was way back in 1543 when a polish astrologist with name *Nicolaus Copernicus*, went against the thoughts of the period which saw the Earth as the centre of the universe, known as the geocentric theory, that combined Aristotle's cosmological system with astronomical one of Ptolemy.
 
 He wasn't the first person to formulate the idea, in fact, the heliocentric theory dates back to 300 b.C with greek astronomist, but Nicolaus was the fist that was able to prove it with mathematics procedures, reversing completely the concept on which the people and scientist were rooted.
 
 We start our journey from here, we came back with a **travel time** in the XVI century, trying to walk down the same path that Nicolaus made during his formulation and demonstration of his theory.
 
 You must be excited to start, so write down the right code and go.
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
