import UIKit
import PlaygroundSupport
import ARKit

@objc(InitialPageViewController)
@available(iOS 11.0, *)
public class InitialPageViewController: UIViewController {
    
    // Simple check
    lazy var isARWorldTrackingSupported: Bool = { return ARWorldTrackingConfiguration.isSupported }()
    
    // MARK: - UIViewController
    override public func viewDidLoad(){
        super.viewDidLoad();
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        // Do a simple check
        guard isARWorldTrackingSupported else {
            // TODO: Unsupported Message
            return
        }
        
        // Do the request to access to the camera
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            // TODO: Give access to the camera: Message
        }
    }
    
    // MARK: - Functions
    func startTimeTravel() {

        // Do a simple check
//        guard ARWorldTrackingConfiguration.isSupported else { return }
//        view.backgroundColor = UIColor.white
        // Create a ARSCNView and set the constraints
        let sceneView = ARSCNView(frame: view.frame)
        sceneView.session = ARSession()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: Hide the image of  Copernicus
        view.addSubview(sceneView)
        
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            sceneView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            sceneView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            ])
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.autoenablesDefaultLighting = true
        

    }
}

// MARK: Extension
@available(iOS 11.0, *)
extension InitialPageViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        guard let liveViewMessage = MessageFromContentsToLiveView(playgroundValue: message) else { return }
        
        switch liveViewMessage {
        case .startTimeTravel:
            startTimeTravel()
        default:
            break
        }
    }
}
