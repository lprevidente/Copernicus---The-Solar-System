import ARKit
import UIKit

@available(iOS 11.0, *)
extension SceneViewController {
    
    func createParentEarth() {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false) else {
            statusViewController.show(message: whereIsTheSun)
            return
        }
        let earthParent = SCNNode()
        earthParent.name = "earthParent"
        earthParent.position = sun.position
        
        let earthParentRotation = Rotation(time: 10)
        earthParent.runAction(earthParentRotation)
        
        if let earthParentEx = self.sceneView.scene.rootNode.childNode(withName: "earthParent", recursively: false) {
            self.sceneView.scene.rootNode.replaceChildNode(earthParentEx, with: earthParent)
        } else {
            self.sceneView.scene.rootNode.addChildNode(earthParent)
        }
        
    }
    
    func createEarthWithTexturesAndRotation() {
        guard let earthParent = self.sceneView.scene.rootNode.childNode(withName: "earthParent", recursively: false) else {
            statusViewController.show(message: somethingIsMissing)
            return
        }
        
        let earth = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "EarthTexture.jpg")!, specular: UIImage(named: "EarthSpecular.tif")!, emission: UIImage(named: "EarthCloudsTexture.jpg")!, normal: UIImage(named: "EarthNormal.tif")!, position: SCNVector3(0.8,0,0))
        
        earth.name = "Earth"
        let earthRotation = Rotation(time: 7)
        earth.runAction(earthRotation)
        
        if let earthEx = earthParent.childNode(withName: "Earth", recursively: false) {
           earthParent.replaceChildNode(earthEx, with: earth)
        } else {
           earthParent.addChildNode(earth)
        }
        self.send(MessageFromLiveViewToContents.succeeded.playgroundValue)
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
}
