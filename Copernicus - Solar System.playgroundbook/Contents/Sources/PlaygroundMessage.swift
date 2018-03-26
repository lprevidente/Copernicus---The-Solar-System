import Foundation
import PlaygroundSupport

// Defines a type that represents a specific type of message
public protocol PlaygroundMessageType {
    init?(rawValue: String)
    var rawValue: String { get }
}

// Protocol that define the type of Playground Message
public protocol PlaygroundMessage {
    associatedtype T: PlaygroundMessageType
    
    var messageType: T { get }
    
    init?(messageType: T, parametersEncoded: Data?)
    
    func encodeParameters() -> Data?
}

// MARK: Extension
// Add encoding func
public extension PlaygroundMessage {
    
    /// An initializer to create a `PlaygroundMessage` from a `PlaygroundValue` that contains an encoded type and optional payload
    public init?(playgroundValue: PlaygroundValue) {
        // Extract the required values from the supplied PlaygroundValue
        guard case let .array(values) = playgroundValue, !values.isEmpty else { fatalError("Expected an array of values") }
        guard case let .string(rawType) = values[0] else { fatalError("Unexpected Playground value type") }
        
        // Check if this is a supported type
        guard let messageType = T(rawValue: rawType) else { return nil }
        
        // Extract any encoded payload.
        let parametersEncoded: Data?
        if values.count > 1, case let .data(parameters) = values[1] {
            parametersEncoded = parameters
        }
        else {
            parametersEncoded = nil
        }
        
        self.init(messageType: messageType, parametersEncoded: parametersEncoded)
    }
    
    // A `PlaygroundValue` representation of the message
    // Playground Value = [ nameFunction, data(parameters) ]
    public var playgroundValue: PlaygroundValue {
        if let parametersEncoded = self.encodeParameters() {
            return .array([.string(messageType.rawValue), .data(parametersEncoded)])
        }
        else {
            return .array([.string(messageType.rawValue)])
        }
    }
}
