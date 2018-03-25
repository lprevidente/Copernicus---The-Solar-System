import ARKit
import UIKit

@available(iOS 11.0, *)
extension SceneViewController {
    
    func createMoon() {
        guard let earthParent = self.sceneView.scene.rootNode.childNode(withName: "earthParent", recursively: false) else {
            return
        }
        
        guard let earth = earthParent.childNode(withName: "Earth", recursively: false) else {
            return
        }
        let moonParent = SCNNode()
        moonParent.position = earth.position
        moonParent.name = "moonParent"
        
        let moonParentRotation = Rotation(time: 5)
        moonParent.runAction(moonParentRotation)
        
        if let moonParentEx = earthParent.childNode(withName: "moonParent", recursively: false) {
            earthParent.replaceChildNode(moonParentEx, with: moonParent)
        } else {
            earthParent.addChildNode(moonParent)
        }
        
        let moon = planet(geometry: SCNSphere(radius: 0.01), diffuse: UIImage(named: "MoonTexture.jpg")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, 0.12))
        
        moon.name = "Moon"
        
        if let moonEx = moonParent.childNode(withName: "Moon", recursively: false) {
            moonParent.replaceChildNode(moonEx, with: moon)
        } else {
            moonParent.addChildNode(moon)
        }
        
        self.send(MessageFromLiveViewToContents.succeeded.playgroundValue)
    }
}
