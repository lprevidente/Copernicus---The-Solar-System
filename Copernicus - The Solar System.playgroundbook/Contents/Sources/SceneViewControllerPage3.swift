import ARKit
import UIKit

@available(iOS 11.0, *)
extension SceneViewController {
    
    // First I need to create a Parent Node for Earth. Its positions is the centre of the Sun
    func createParentEarth(timeRotation: TimeInterval) {
        // This is the previouslys
        createSun(radius: 0.35, position: SCNVector3(0,0,-2))
        setTextureToSun(sendMessage: false)
        setSpeedRotationToSun(speedRotation: 8, sendMessage: false)
        
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false) else {
            statusViewController.show(message: whereIsTheSun)
            return
        }
        let earthParent = SCNNode()
        
        let earthName: String = planets[2]
        earthParent.name = "\(earthName)Parent"
        earthParent.position = sun.position
        
        let earthParentRotation = Rotation(time: timeRotation)
        earthParent.runAction(earthParentRotation)
        
        if let earthParentEx = self.sceneView.scene.rootNode.childNode(withName: "\(earthName)Parent", recursively: false) {
            self.sceneView.scene.rootNode.replaceChildNode(earthParentEx, with: earthParent)
        } else {
            self.sceneView.scene.rootNode.addChildNode(earthParent)
        }
    }
    
    // I create the Earth that is a child of node created before
    func createEarth(radius: CGFloat, position: SCNVector3, timeRotation: TimeInterval, needTorus: Bool) {
        let earthName: String = planets[2]
        guard let earthParent = self.sceneView.scene.rootNode.childNode(withName: "\(earthName)Parent", recursively: false) else {
            self.send(MessageFromLiveViewToContents.failed.playgroundValue)
            statusViewController.show(message: somethingIsMissing)
            return
        }
        
        let earth = createPlanetNode(geometry: SCNSphere(radius: radius), diffuse: UIImage(named: "\(earthName)Texture.jpg")!, specular: UIImage(named: "\(earthName)Specular.tif")!, emission: UIImage(named: "\(earthName)CloudsTexture.jpg")!, normal: UIImage(named: "\(earthName)Normal.tif")!, position: position)
        
        earth.name = earthName
        let earthRotation = Rotation(time: timeRotation)
        earth.runAction(earthRotation)
        
        if let earthEx = earthParent.childNode(withName: earthName, recursively: false) {
           earthParent.replaceChildNode(earthEx, with: earth)
        } else {
           earthParent.addChildNode(earth)
        }
        
        if needTorus {
            let torus =  SCNTorus(ringRadius: CGFloat(earth.position.x) , pipeRadius: 0.001)
            torus.firstMaterial?.diffuse.contents = UIColor.black.withAlphaComponent(0.3)
            let torusNode = SCNNode(geometry: torus)
            earthParent.addChildNode(torusNode)
        } else{
            self.send(MessageFromLiveViewToContents.succeeded.playgroundValue)
        }
    }
    
    // MARK: - Func create Node Planet
    func createPlanetNode(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
}
