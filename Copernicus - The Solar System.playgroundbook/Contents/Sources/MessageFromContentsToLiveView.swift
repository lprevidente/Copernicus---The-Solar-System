import UIKit
import ARKit

public enum MessageFromContentsToLiveView: PlaygroundMessage {
    
    // List of case
    case startTimeTravel
    case createSun(radius: CGFloat, position: SCNVector3)
    case setSpeedRotationToSun(speedRotation: Int)
    case setTextureToSun
    case createParentEarth
    case createEarth
    case createSolarSystem
    
    // Create a Enumeration
    public enum MessageType: String, PlaygroundMessageType {
        case startTimeTravel
        case createSun
        case setSpeedRotationToSun
        case setTextureToSun
        case createParentEarth
        case createEarth
        case createSolarSystem
    }
    
    // Define the type of message that I can have
    public var messageType: MessageType {
        switch self {
        case .startTimeTravel:
            return .startTimeTravel
            
        case .createSun(radius:position:):
            return .createSun
            
        case .setTextureToSun:
            return .setTextureToSun
            
        case .setSpeedRotationToSun(speedRotation:):
            return .setSpeedRotationToSun
            
        case .createParentEarth:
            return .createParentEarth
            
        case .createEarth:
            return .createEarth

        case .createSolarSystem:
            return .createSolarSystem
        }
    }
    
    // MARK: - Init
    public init?(messageType: MessageType, parametersEncoded: Data?) {
        let decoder = JSONDecoder()
        
        // If there are parameters, I'll get them
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
            
        case .setTextureToSun:
            self = .setTextureToSun
            
        case .setSpeedRotationToSun:
            guard let parametersEncoded = parametersEncoded,
                  let parameters = try? decoder.decode(setSpeedRotationParameters.self, from: parametersEncoded)
            else {
                return nil
            }
            self = .setSpeedRotationToSun(speedRotation: parameters.speedRotation)
            
        case .createParentEarth:
            self = .createParentEarth
            
        case .createEarth:
            self = .createEarth

        case .createSolarSystem:
            self = .createSolarSystem
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
            
        case .setTextureToSun:
            return nil;
            
        case let .setSpeedRotationToSun(speedRotation: speedRotation):
            let parameters = setSpeedRotationParameters(speedRotation: speedRotation)
            return try! encoder.encode(parameters)
            
        case .createParentEarth:
            return nil
            
        case .createEarth:
            return nil

        case .createSolarSystem:
            return nil
        }
    }
}
