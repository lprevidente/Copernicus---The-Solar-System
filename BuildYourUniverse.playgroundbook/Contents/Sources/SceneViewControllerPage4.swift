import ARKit
import UIKit

@available(iOS 11.0, *)
extension SceneViewController {
    
    func createMoon(radius: CGFloat, position: SCNVector3, timeRotation: TimeInterval) {
        let earthName: String = planets[2]
        
        guard let earthParent = self.sceneView.scene.rootNode.childNode(withName: "\(earthName)Parent", recursively: false),
              let earth = earthParent.childNode(withName: earthName, recursively: false) else {
            return
        }
        // Creation of Parent Node Moon. Set Position, Name and Rotation
        let moonParent = SCNNode()
        moonParent.position = earth.position
        let moonName: String = "Moon"
        moonParent.name = "\(moonName)Parent"
        
        let moonParentRotation = Rotation(time: timeRotation)
        moonParent.runAction(moonParentRotation)
        
        // Check the presence of another Parent Node
        if let moonParentEx = earthParent.childNode(withName: "\(moonName)Parent", recursively: false) {
            earthParent.replaceChildNode(moonParentEx, with: moonParent)
        } else {
            earthParent.addChildNode(moonParent)
        }
        
        // Creation of Moon. Set Position, Name and Rotation
        let moon = createPlanetNode(geometry: SCNSphere(radius: radius), diffuse: UIImage(named: "\(moonName)Texture.jpg")!, specular: nil, emission: nil, normal: nil, position: position)
        
        let timeIntervalNode = timeRotation - TimeInterval(2)
        let moonRotation = Rotation(time: timeIntervalNode)
        moon.runAction(moonRotation)
        moon.name = moonName
        
        // Check the presence of another Moon
        if let moonEx = moonParent.childNode(withName: moonName, recursively: false) {
            moonParent.replaceChildNode(moonEx, with: moon)
        } else {
            moonParent.addChildNode(moon)
        }
        
    }
    
    private func createPlanet(name: String, positionPlanet: SCNVector3, timeRotation: TimeInterval, radius: CGFloat) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false ) else {
            return
        }
        // Creation of Parent Node. Set Position, Name and Rotation
        let planetParent = SCNNode()
        planetParent.name = "\(name)Parent"
        planetParent.position = sun.position
        let planetParentRotation = Rotation(time: timeRotation)
        planetParent.runAction(planetParentRotation)
        
        // Check the presence of another Parent Node
        if let planetParentEx = self.sceneView.scene.rootNode.childNode(withName: "\(name)Parent", recursively: false) {
            self.sceneView.scene.rootNode.replaceChildNode(planetParentEx, with: planetParent)
        } else {
            self.sceneView.scene.rootNode.addChildNode(planetParent)
        }
        
        // Creation of Planet. Set Position, Name and Rotation
        let planetNode = createPlanetNode(geometry: SCNSphere(radius: radius), diffuse: UIImage(named: "\(name)Texture.jpg")!, specular: nil, emission: nil, normal: nil, position: positionPlanet)
        
        let timeIntervalNode = timeRotation - TimeInterval(2)
        let planetRotation = Rotation(time: timeIntervalNode)
        planetNode.runAction(planetRotation)
        planetNode.name = name
        
        // Check the presence of another Planet
        if let planetNodeEx = planetParent.childNode(withName: name , recursively: false) {
            planetParent.replaceChildNode(planetNodeEx, with: planetNode)
        } else {
            planetParent.addChildNode(planetNode)
        }
        
        // Create a Torus for the orbit
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
        let mercuryName = planets[0]
        createPlanet(name: mercuryName , positionPlanet: SCNVector3(0.4,0,0), timeRotation: 6, radius: 0.03 )
        
        // Venus
        let venusName = planets[1]
        createPlanet(name: venusName, positionPlanet: SCNVector3(0.6,0,0), timeRotation: 8, radius: 0.04 )
        
        // Earth
        createParentEarth(timeRotation: 10)
        createEarth(radius: 0.1, position: SCNVector3(0.8, 0, 0), timeRotation: 7, needTorus: true)
        
        // Create Moon
        createMoon(radius: 0.01, position: SCNVector3(0, 0, 0.12), timeRotation: 5);
    
        // Mars
        let marsName = planets[3]
        createPlanet(name: marsName, positionPlanet: SCNVector3(1,0,0), timeRotation: 12, radius: 0.04 )

        // Jupiter
        let jupiterName = planets[4]
        createPlanet(name: jupiterName, positionPlanet: SCNVector3(1.2,0,0), timeRotation: 14, radius: 0.08)
        
        // Saturn
        let saturnName = planets[5]
        createPlanet(name: saturnName, positionPlanet: SCNVector3(1.6,0,0), timeRotation: 16, radius: 0.15)
        
        // Uranus
        let uranusName = planets[6]
        createPlanet(name: uranusName, positionPlanet: SCNVector3(1.9,0,0), timeRotation: 18, radius: 0.1)
        
        // Neptune
        let neptuneName = planets[7]
        createPlanet(name: neptuneName, positionPlanet: SCNVector3(2.3,0,0), timeRotation: 20, radius: 0.1)
        
        // Pluto
        let plutoName = planets[8]
        createPlanet(name: plutoName, positionPlanet: SCNVector3(2.5,0,0), timeRotation: 22, radius: 0.02)
        
    }
}
