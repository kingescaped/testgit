
import CoreGraphics
import SpriteKit

public extension CGPoint {
  
  public init(vector: CGVector) {
    self.init(x: vector.dx, y: vector.dy)
  }

  public init(angle: CGFloat) {
    self.init(x: cos(angle), y: sin(angle))
  }

  public mutating func offset(dx: CGFloat, dy: CGFloat) -> CGPoint {
    x += dx
    y += dy
    return self
  }

  public func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }

  public func lengthSquared() -> CGFloat {
    return x*x + y*y
  }

  func normalized() -> CGPoint {
    let len = length()
    return len>0 ? self / len : CGPoint.zero
  }

  public mutating func normalize() -> CGPoint {
    self = normalized()
    return self
  }

  public func distanceTo(_ point: CGPoint) -> CGFloat {
    return (self - point).length()
  }

  public var angle: CGFloat {
    return atan2(y, x)
  }
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (left: inout CGPoint, right: CGPoint) {
  left = left + right
}

public func + (left: CGPoint, right: CGVector) -> CGPoint {
  return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

public func += (left: inout CGPoint, right: CGVector) {
  left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func -= (left: inout CGPoint, right: CGPoint) {
  left = left - right
}

public func - (left: CGPoint, right: CGVector) -> CGPoint {
  return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

public func -= (left: inout CGPoint, right: CGVector) {
  left = left - right
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public func *= (left: inout CGPoint, right: CGPoint) {
  left = left * right
}

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func *= (point: inout CGPoint, scalar: CGFloat) {
  point = point * scalar
}

public func * (left: CGPoint, right: CGVector) -> CGPoint {
  return CGPoint(x: left.x * right.dx, y: left.y * right.dy)
}

public func *= (left: inout CGPoint, right: CGVector) {
  left = left * right
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public func /= (left: inout CGPoint, right: CGPoint) {
  left = left / right
}

public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

public func /= (point: inout CGPoint, scalar: CGFloat) {
  point = point / scalar
}

public func / (left: CGPoint, right: CGVector) -> CGPoint {
  return CGPoint(x: left.x / right.dx, y: left.y / right.dy)
}

public func /= (left: inout CGPoint, right: CGVector) {
  left = left / right
}

public func lerp(start: CGPoint, end: CGPoint, t: CGFloat) -> CGPoint {
  return start + (end - start) * t
}
