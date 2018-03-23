import ARKit
import UIKit

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
