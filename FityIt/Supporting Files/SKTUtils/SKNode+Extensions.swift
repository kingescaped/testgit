
import SpriteKit

public extension SKNode {

  public var scaleAsPoint: CGPoint {
    get {
      return CGPoint(x: xScale, y: yScale)
    }
    set {
      xScale = newValue.x
      yScale = newValue.y
    }
  }

  public func afterDelay(_ delay: TimeInterval, runBlock block: @escaping () -> Void) {
    run(SKAction.sequence([SKAction.wait(forDuration: delay), SKAction.run(block)]))
  }

  public func bringToFront() {
    if let parent = self.parent{
      removeFromParent()
      parent.addChild(self)
    }
  }

  public func rotateToVelocity(_ velocity: CGVector, rate: CGFloat) {
    
    let newAngle = atan2(velocity.dy, velocity.dx) - π/2

    if newAngle - zRotation > π {
      zRotation += π * 2.0
    } else if zRotation - newAngle > π {
      zRotation -= π * 2.0
    }

    zRotation += (newAngle - zRotation) * rate
  }
}
