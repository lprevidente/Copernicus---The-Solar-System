import UIKit
import ARKit
import PlaygroundSupport

@objc(SceneViewController)
@available(iOS 11.0, *)
public class SceneViewController: UIViewController {
    // MARK: - Outlets
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
    public let somethingIsMissing = "Something is missing 🧐"
    
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
}

// MARK: - Extension Int
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}

// MARK: Extension Message Handler
@available(iOS 11.0, *)
extension SceneViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        // Check the availability of the message to Live View
        guard let liveViewMessage = MessageFromContentsToLiveView(playgroundValue: message) else { return }
        
        // Do a comparison  to identify the type of liveMessage and call the right func
        switch liveViewMessage {
        case let .createSun(radius: radius, position: position):
            createSun(radius: radius, position: position);
        case .setTextureToSun:
            setTextureToSun();
        case let .setSpeedRotationToSun(speedRotation: speedRotation):
            setSpeedRotationToSun(speedRotation: speedRotation);
        case .createParentEarth:
            createParentEarth();
        case .createEarthWithTexturesAndRotation:
            createEarthWithTexturesAndRotation();
        case .createMoon:
            createMoon();
        case .createSolarSystem:
            createSolarSystem();
        default:
            break
        }
    }
}

// MARK: Extension ARSCNDelegate
@available(iOS 11.0, *)
extension SceneViewController: ARSCNViewDelegate, ARSessionDelegate {
    
    public func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        // Give to the user some hints based on the tracking state
        switch camera.trackingState {
        case .notAvailable:
            statusViewController.show(message: trackingNotAvailable )
        case .limited(.insufficientFeatures):
            statusViewController.show(message: featureMissingMessage)
        case .limited(.excessiveMotion):
            statusViewController.show(message: excessiveMotionMessage)
        case .normal:
            statusViewController.show(message: scanEnvoiroment)
        default:
            break;
        }
    }
}

