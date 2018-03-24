import ARKit
import UIKit

@available(iOS 11.0, *)
extension SceneViewController {
    
    func createMoon() {
        guard let earthParent = self.sceneView.scene.rootNode.childNode(withName: "earthParent", recursively: false) else {
            return
        }
        let moonParent = SCNNode()
        moonParent.position = SCNVector3(1.2 ,0 , 0)
        moonParent.name = "moonParent"
        
        if let moonParentEx = self.sceneView.scene.rootNode.childNode(withName: "moonParent", recursively: false) {
            earthParent.replaceChildNode(moonParentEx, with: moonParent)
        } else {
            earthParent.addChildNode(moonParent)
        }
        
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "MoonTexture.jpg")!, specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        moon.name = "Moon"
        let moonRotation = Rotation(time: 5)
        moonParent.runAction(moonRotation)
        
        if let moonEx = self.sceneView.scene.rootNode.childNode(withName: "Moon", recursively: false) {
            moonParent.replaceChildNode(moonEx, with: moon)
        } else {
            moonParent.addChildNode(moon)
        }
        self.send(MessageFromLiveViewToContents.succeeded.playgroundValue)
    }
}
