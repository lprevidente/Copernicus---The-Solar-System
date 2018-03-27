import UIKit
import ARKit

struct createSunParameters: Codable {
    var radius: CGFloat
    var position: SCNVector3
}

struct setSpeedRotationParameters: Codable {
    var speedRotation: Int
}

extension SCNVector3: Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.x = try container.decode(Float.self)
        self.y = try container.decode(Float.self)
        self.z = try container.decode(Float.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.x)
        try container.encode(self.y)
        try container.encode(self.z)
    }
}
