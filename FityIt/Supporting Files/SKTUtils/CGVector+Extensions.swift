
import CoreGraphics
import SpriteKit

public extension CGVector {
    
  public init(point: CGPoint) {
    self.init(dx: point.x, dy: point.y)
  }

  public init(angle: CGFloat) {
    self.init(dx: cos(angle), dy: sin(angle))
  }

  public mutating func offset(dx: CGFloat, dy: CGFloat) -> CGVector {
    self.dx += dx
    self.dy += dy
    return self
  }

  public func length() -> CGFloat {
    return sqrt(dx*dx + dy*dy)
  }

  public func lengthSquared() -> CGFloat {
    return dx*dx + dy*dy
  }

  func normalized() -> CGVector {
    let len = length()
    return len>0 ? self / len : CGVector.zero
  }

  public mutating func normalize() -> CGVector {
    self = normalized()
    return self
  }

  public func distanceTo(_ vector: CGVector) -> CGFloat {
    return (self - vector).length()
  }

  public var angle: CGFloat {
    return atan2(dy, dx)
  }
}


public func + (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

public func += (left: inout CGVector, right: CGVector) {
  left = left + right
}

public func - (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

public func -= (left: inout CGVector, right: CGVector) {
  left = left - right
}

public func * (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

public func *= (left: inout CGVector, right: CGVector) {
  left = left * right
}

public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
  return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

public func *= (vector: inout CGVector, scalar: CGFloat) {
  vector = vector * scalar
}

public func / (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

public func /= (left: inout CGVector, right: CGVector) {
  left = left / right
}

public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
  return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}

public func /= (vector: inout CGVector, scalar: CGFloat) {
  vector = vector / scalar
}

public func lerp(start: CGVector, end: CGVector, t: CGFloat) -> CGVector {
  return start + (end - start) * t
}
