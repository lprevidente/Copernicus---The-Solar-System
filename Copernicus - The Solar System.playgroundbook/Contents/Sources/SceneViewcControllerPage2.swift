import UIKit
import ARKit
import PlaygroundSupport

@available(iOS 11.0, *)
extension SceneViewController {
    
    // MARK: - Functions For the Sun
    func createSun(radius: CGFloat, position: SCNVector3) {
        
        if ( radius >= 3 ) {
            statusViewController.show(message: tooBig )
            return
        }
        let sun = SCNNode(geometry: SCNSphere(radius: radius))
        sun.name = sunName
        sun.position = position
        // Check if there is another sun, and replace it with the new one
        if let sunEx = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false) {
            self.sceneView.scene.rootNode.replaceChildNode(sunEx, with: sun)
        } else {
            self.sceneView.scene.rootNode.addChildNode(sun)
        }
        
        if !sun.hasActions, let texutureColor = sun.geometry?.firstMaterial?.diffuse.contents as? UIColor {
            self.send(MessageFromLiveViewToContents.failed.playgroundValue)
        }
    }
    
    func setTextureToSun(sendMessage: Bool) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false) else {
            statusViewController.show(message: whereIsTheSun)
            return
        }
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "\(sunName)Texture.jpg")
        
        if sun.hasActions, sendMessage {
            self.send(MessageFromLiveViewToContents.succeeded.playgroundValue)
        } else if sendMessage {
            self.send(MessageFromLiveViewToContents.failed.playgroundValue)
        }
    }
    
    // Give rotation to Sun
    func setSpeedRotationToSun(speedRotation: Int, sendMessage: Bool){
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false) else {
            statusViewController.show(message: whereIsTheSun)
            return
        }
        // Do a check on values
        if speedRotation < 1 {
            statusViewController.show(message: tooSpeed)
            return
        } else if  speedRotation > 15 {
            statusViewController.show(message: tooSlow)
            return
        }
        
        self.speedRotation = speedRotation
        let sunAction = Rotation(time: TimeInterval(self.speedRotation))
        // If there is a previous action I'll remove it
        if sun.hasActions {
            sun.removeAction(forKey: "\(sunName)Rotation")
        }
        sun.runAction(sunAction, forKey: "\(sunName)Rotation")
        // Check if the Sun has a Texture
        if let texutureColor = sun.geometry?.firstMaterial?.diffuse.contents as? UIImage, sendMessage {
            self.send(MessageFromLiveViewToContents.succeeded.playgroundValue)
        } else if sendMessage {
            self.send(MessageFromLiveViewToContents.failed.playgroundValue)
        }
    }
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    
    // MARK: - Handle Gesture Recognizer
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if !hitTest.isEmpty {
            let resultName = hitTest.first!.node.name
            switch resultName {
            case sunName?:
                statusViewController.show(message: touchOnSun);
            default:
                for planet in planets {
                    if planet == resultName {
                        statusViewController.show(message: "\(touchOn) \(planet)")
                    }
                }
                break;
            }
        }
    }
    
    // Increase the speed of The sun
    @objc func handleSwipeRight(sender: UISwipeGestureRecognizer) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false) else {
            return
        }
        if sun.hasActions {
            self.speedRotation += 1
            setSpeedRotationToSun(speedRotation: self.speedRotation, sendMessage: true)
        }
    }
    
    // Decrease the speed of the sun
    @objc func handleSwipeLeft(sender: UISwipeGestureRecognizer) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: sunName, recursively: false) else {
            return
        }
        if !sun.hasActions {
            setSpeedRotationToSun(speedRotation: 10, sendMessage: true)
        } else {
            self.speedRotation += -1
            setSpeedRotationToSun(speedRotation: self.speedRotation, sendMessage: true)
        }
    }
}
