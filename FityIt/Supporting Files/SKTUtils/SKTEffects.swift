
import SpriteKit

public class SKTEffect {
  unowned var node: SKNode
  var duration: TimeInterval
  public var timingFunction: ((CGFloat) -> CGFloat)?

  public init(node: SKNode, duration: TimeInterval) {
    self.node = node
    self.duration = duration
    timingFunction = SKTTimingFunctionLinear
  }

  public func update(_ t: CGFloat) {
    // subclasses implement this
  }
}

public class SKTMoveEffect: SKTEffect {
  var startPosition: CGPoint
  var delta: CGPoint
  var previousPosition: CGPoint
  
  public init(node: SKNode, duration: TimeInterval, startPosition: CGPoint, endPosition: CGPoint) {
    previousPosition = node.position
    self.startPosition = startPosition
    delta = endPosition - startPosition
    super.init(node: node, duration: duration)
  }
  
  public override func update(_ t: CGFloat) {
    
    let newPosition = startPosition + delta*t
    let diff = newPosition - previousPosition
    previousPosition = newPosition
    node.position += diff
  }
}

public class SKTScaleEffect: SKTEffect {
  var startScale: CGPoint
  var delta: CGPoint
  var previousScale: CGPoint

  public init(node: SKNode, duration: TimeInterval, startScale: CGPoint, endScale: CGPoint) {
    previousScale = CGPoint(x: node.xScale, y: node.yScale)
    self.startScale = startScale
    delta = endScale - startScale
    super.init(node: node, duration: duration)
  }

  public override func update(_ t: CGFloat) {
    let newScale = startScale + delta*t
    let diff = newScale / previousScale
    previousScale = newScale
    node.xScale *= diff.x
    node.yScale *= diff.y
  }
}


public class SKTRotateEffect: SKTEffect {
  var startAngle: CGFloat
  var delta: CGFloat
  var previousAngle: CGFloat

  public init(node: SKNode, duration: TimeInterval, startAngle: CGFloat, endAngle: CGFloat) {
    previousAngle = node.zRotation
    self.startAngle = startAngle
    delta = endAngle - startAngle
    super.init(node: node, duration: duration)
  }

  public override func update(_ t: CGFloat) {
    let newAngle = startAngle + delta*t
    let diff = newAngle - previousAngle
    previousAngle = newAngle
    node.zRotation += diff
  }
}


public extension SKAction {
  public class func actionWithEffect(_ effect: SKTEffect) -> SKAction {
    return SKAction.customAction(withDuration: effect.duration) { node, elapsedTime in
      var t = elapsedTime / CGFloat(effect.duration)

      if let timingFunction = effect.timingFunction {
        t = timingFunction(t)
      }

      effect.update(t)
    }
  }
}
