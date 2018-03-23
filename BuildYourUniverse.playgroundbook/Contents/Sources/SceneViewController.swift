import UIKit
import ARKit
import PlaygroundSupport

@objc(SceneViewController)
@available(iOS 11.0, *)
public class SceneViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView! {
        didSet{
            sceneView.delegate = self
            sceneView.session.delegate = self
        }
    }
    
    // MARK: - Proprieties
    lazy var isARWorldTrackingSupported: Bool = { return ARWorldTrackingConfiguration.isSupported }()
    public let featureMissingMessage = " 💡 I need Light 💡"
    public let excessiveMotionMessage = "🐌 Ehi Slowly 🐌"
    public let trackingNotAvailable = "Tracking not Available 😖"
    public let scanEnvoiroment = "Scan the Environment 📸"
    public let whereIsTheSun = "Where is the sun? ☀️😱"
    public let touchOnSun = "OH! Doesn't hurt? ☀️🔥"
    public let tooSpeed = "Too Speed 🏎"
    public let tooSlow = "Too Slow 🐌"
    
    // View controller that handles the display of user hints on screen
    lazy var statusViewController: StatusViewController = {
        return childViewControllers.lazy.flatMap({ $0 as? StatusViewController }).first!
    }()
    
    var session: ARSession {
        return sceneView.session
    }
    
    var speedRotation: Int = 0;
    
    // MARK: - UIViewController
    override public func viewDidLoad() {
        super.viewDidLoad()
        sceneView.autoenablesDefaultLighting = true
        
        // Add Some Swipe Gesture Reconizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeGestureRecognizerRight.direction = .right
        self.sceneView.addGestureRecognizer(swipeGestureRecognizerRight);
        
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeGestureRecognizerRight.direction = .left
        self.sceneView.addGestureRecognizer(swipeGestureRecognizerLeft);
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do a simple check
        guard isARWorldTrackingSupported else {
            statusViewController.show(message: trackingNotAvailable)
            return
        }
        
        // Every time the view appear I reset the configuration
        let configuration = ARWorldTrackingConfiguration()
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                  ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(configuration ,options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - Functions
    func createSun(radius: CGFloat, position: SCNVector3) {
        // TODO: Check on value
        // TODO: Add only after that the scanning is completed
        let sun = SCNNode(geometry: SCNSphere(radius: radius))
        sun.name = "Sun"
        sun.position = position
        // Check if there is another sun, and replace it with the new one
        if let sunEx = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false) {
            self.sceneView.scene.rootNode.replaceChildNode(sunEx, with: sun)
        } else {
            self.sceneView.scene.rootNode.addChildNode(sun)
        }
    }
    
    func setTexture() {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false) else {
            statusViewController.show(message: whereIsTheSun)
            return
        }
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "SunTexture.jpg")
    }
    
    // Give rotation to Sun
    func setSpeedRotation(speedRotation: Int){
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false) else {
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
            sun.removeAction(forKey: "sunRotation")
        }
        sun.runAction(sunAction, forKey: "sunRotation")
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
            case "Sun"?:
                statusViewController.show(message: touchOnSun);
            default:
                break;
            }
        }
    }
    
    // Increase the speed of The sun
    @objc func handleSwipeRight(sender: UISwipeGestureRecognizer) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false) else {
            return
        }
        if sun.hasActions {
            self.speedRotation += 1
            setSpeedRotation(speedRotation: self.speedRotation)
        }
    }
    
    // Decrease the speed of the sun
    @objc func handleSwipeLeft(sender: UISwipeGestureRecognizer) {
        guard let sun = self.sceneView.scene.rootNode.childNode(withName: "Sun", recursively: false) else {
            return
        }
        if !sun.hasActions {
            setSpeedRotation(speedRotation: 10)
        } else {
            self.speedRotation += -1
            setSpeedRotation(speedRotation: self.speedRotation)
        }
    }
}

// MARK: - Extension Int
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}

// MARK: Extension
@available(iOS 11.0, *)
extension SceneViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        // Check the availability of the message to Live View
        guard let liveViewMessage = MessageFromContentsToLiveView(playgroundValue: message) else { return }
        
        // Do a comparison  to identify the type of liveMessage and call the right func
        switch liveViewMessage {
        case let .createSun(radius: radius, position: position):
            createSun(radius: radius, position: position);
        case .setTexture:
            setTexture();
        case let .setSpeedRotation(speedRotation: speedRotation):
            setSpeedRotation(speedRotation: speedRotation);
        default:
            break
        }
    }
}

