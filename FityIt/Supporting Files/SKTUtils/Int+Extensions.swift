
import CoreGraphics

public extension Int {

  public func clamped(_ range: Range<Int>) -> Int {
    return (self < range.lowerBound) ? range.lowerBound : ((self >= range.upperBound) ? range.upperBound - 1: self)
  }

  public func clamped(_ range: ClosedRange<Int>) -> Int {
    return (self < range.lowerBound) ? range.lowerBound : ((self > range.upperBound) ? range.upperBound: self)
  }

  public mutating func clamp(_ range: Range<Int>) -> Int {
    self = clamped(range)
    return self
  }

  public mutating func clamp(_ range: ClosedRange<Int>) -> Int {
    self = clamped(range)
    return self
  }

  public func clamped(_ v1: Int, _ v2: Int) -> Int {
    let min = v1 < v2 ? v1 : v2
    let max = v1 > v2 ? v1 : v2
    return self < min ? min : (self > max ? max : self)
  }

  public mutating func clamp(_ v1: Int, _ v2: Int) -> Int {
    self = clamped(v1, v2)
    return self
  }

  public static func random(_ range: Range<Int>) -> Int {
    return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound - 1))) + range.lowerBound
  }

  public static func random(_ range: ClosedRange<Int>) -> Int {
    return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
  }

  public static func random(_ n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }

  public static func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
  }
}
