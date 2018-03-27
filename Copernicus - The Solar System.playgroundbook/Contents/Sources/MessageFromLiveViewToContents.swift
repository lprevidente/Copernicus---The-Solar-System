import Foundation
import PlaygroundSupport

public enum MessageFromLiveViewToContents: PlaygroundMessage {
    
    case failed
    case succeeded
    
    public enum MessageType: String, PlaygroundMessageType {
        case failed
        case succeeded
    }
    
    public var messageType: MessageType {
        switch self {
        case .failed:
            return .failed
        case .succeeded:
            return .succeeded
        }
    }
    
    public init?(messageType: MessageType, parametersEncoded: Data?) {
        switch messageType {
        case .failed:
            self = .failed
        case .succeeded:
            self = .succeeded
        }
    }
    
    public func encodeParameters() -> Data? {
        return nil
    }
}
