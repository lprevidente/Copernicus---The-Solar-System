import UIKit
import ARKit

public enum MessageFromContentsToLiveView: PlaygroundMessage {
    
    // List of case
    case startTimeTravel
    case createSun(radius: CGFloat, position: SCNVector3)
    case setSpeedRotation(speedRotation: Int)
    case setTexture
    
    // Create a Enumeration
    public enum MessageType: String, PlaygroundMessageType {
        case startTimeTravel
        case createSun
        case setSpeedRotation
        case setTexture
    }
    
    // Define the type of message that I can have
    public var messageType: MessageType {
        switch self {
        case .startTimeTravel:
            return .startTimeTravel
        case .createSun(radius:position:):
            return .createSun
        case .setTexture:
            return .setTexture
        case .setSpeedRotation(speedRotation:):
            return .setSpeedRotation
        }
    }
    
    // MARK: - Init
    public init?(messageType: MessageType, parametersEncoded: Data?) {
        let decoder = JSONDecoder()
        
        // If there is parameters, I'll get them
        switch messageType {
            
        case .startTimeTravel:
            self = .startTimeTravel
            
        case .createSun:
            guard let parametersEncoded = parametersEncoded,
                  let parameters = try? decoder.decode(createSunParameters.self, from: parametersEncoded)
            else {
                return nil
            }
            self = .createSun(radius: parameters.radius, position: parameters.position);
            
        case .setTexture:
            self = .setTexture
            
        case .setSpeedRotation:
            guard let parametersEncoded = parametersEncoded,
                  let parameters = try? decoder.decode(setSpeedRotationParameters.self, from: parametersEncoded)
            else {
                return nil
            }
            self = .setSpeedRotation(speedRotation: parameters.speedRotation)
        }
    }
    
    // MARK: - Functions
    // Decode the parameters
    public func encodeParameters() -> Data? {
        let encoder = JSONEncoder()
        
        switch self {
        case .startTimeTravel:
            return nil
            
        case let .createSun(radius: radius, position: position):
            let parameters = createSunParameters(radius: radius, position: position)
            return try! encoder.encode(parameters)
            
        case .setTexture:
            return nil;
            
        case let .setSpeedRotation(speedRotation: speedRotation):
            let parameters = setSpeedRotationParameters(speedRotation: speedRotation)
            return try! encoder.encode(parameters)
        }
    }
}
