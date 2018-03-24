/*:
 
 Here there will be a breif introduction about the playground book
 
 ## **This is Big Bold**
 
 Normal
 
 `Corsivo`.
 
 **Bold**:
 
*Simple bold*!
 
 Button [**Next Chapter**](@next)
 
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

func startTimeTravel() {
    proxy?.send(MessageFromContentsToLiveView.startTimeTravel.playgroundValue)
    //TODO: Right Hint
    page.assessmentStatus = .pass(message: "You Did it!")
}
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, startTimeTravel())
//#-end-hidden-code
//#-editable-code

//#-end-editable-code
