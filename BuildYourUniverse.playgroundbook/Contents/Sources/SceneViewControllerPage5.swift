import ARKit
import UIKit

@available(iOS 11.0, *)
extension SceneViewController {
    
    private func createPlanet(name: String, positionPlanet: SCNVector3, timeRotation: TimeInterval, radius: CGFloat) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false ) else {
            return
        }
        // Creation of Parent Node
        let planetParent = SCNNode()
        planetParent.name = "\(name)Parent"
        planetParent.position = sun.position
        
        if let planetParentEx = self.sceneView.scene.rootNode.childNode(withName: "\(name)Parent", recursively: false) {
            self.sceneView.scene.rootNode.replaceChildNode(planetParentEx, with: planetParent)
        } else {
            self.sceneView.scene.rootNode.addChildNode(planetParent)
        }
        
        let planetParentRotation = Rotation(time: timeRotation)
        planetParent.runAction(planetParentRotation)
        
        // Creation of Planet
        let planetNode = planet(geometry: SCNSphere(radius: radius), diffuse: UIImage(named: "\(name)Texture.jpg")!, specular: nil, emission: nil, normal: nil, position: positionPlanet)
        let timeIntervalNode = timeRotation - TimeInterval(2)
        let planetRotation = Rotation(time: timeIntervalNode)
        planetNode.runAction(planetRotation)
        planetNode.name = name
        
        if let planetNodeEx = planetParent.childNode(withName: name , recursively: false) {
            planetParent.replaceChildNode(planetNodeEx, with: planetNode)
        } else {
            planetParent.addChildNode(planetNode)
        }
        
        let torus =  SCNTorus(ringRadius: CGFloat(positionPlanet.x) , pipeRadius: 0.001)
        torus.firstMaterial?.diffuse.contents = UIColor.gray.withAlphaComponent(0.3)
        let torusNode = SCNNode(geometry: torus)
        planetParent.addChildNode(torusNode)
        
    }
    
    func createSolarSystem() {
        // Sun
        createSun(radius: 0.25, position: SCNVector3(-0.5,-0.5,-1));
        setTextureToSun();
        setSpeedRotationToSun(speedRotation: 3)
        
        // Mercury
        createPlanet(name: "Mercury", positionPlanet: SCNVector3(0.4,0,0), timeRotation: 6, radius: 0.03 )
        
        // Venus
        createPlanet(name: "Venus", positionPlanet: SCNVector3(0.6,0,0), timeRotation: 8, radius: 0.04 )
        
        // Earth
        createParentEarth();
        createEarthWithTexturesAndRotation();
        // Create Moon
        createMoon();
    
        // Mars
        createPlanet(name: "Mars", positionPlanet: SCNVector3(1,0,0), timeRotation: 12, radius: 0.04 )

        // Jupiter
        createPlanet(name: "Jupiter", positionPlanet: SCNVector3(1.2,0,0), timeRotation: 14, radius: 0.08)
        
        // Saturn
        createPlanet(name: "Saturn", positionPlanet: SCNVector3(1.6,0,0), timeRotation: 16, radius: 0.15)
        
        // Uranus
        createPlanet(name: "Uranus", positionPlanet: SCNVector3(1.9,0,0), timeRotation: 18, radius: 0.1)
        
        // Neptune
        createPlanet(name: "Neptune", positionPlanet: SCNVector3(2.1,0,0), timeRotation: 20, radius: 0.1)
        
        // Pluto
        createPlanet(name: "Pluto", positionPlanet: SCNVector3(2.3,0,0), timeRotation: 22, radius: 0.02)
        
    }
}
