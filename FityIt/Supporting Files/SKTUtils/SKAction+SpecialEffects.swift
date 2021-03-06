
import SpriteKit

public extension SKAction {
 
  public class func screenShakeWithNode(_ node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
    let oldPosition = node.position
    let newPosition = oldPosition + amount
    
    let effect = SKTMoveEffect(node: node, duration: duration, startPosition: newPosition, endPosition: oldPosition)
    effect.timingFunction = SKTCreateShakeFunction(oscillations)

    return SKAction.actionWithEffect(effect)
  }

  public class func screenRotateWithNode(_ node: SKNode, angle: CGFloat, oscillations: Int, duration: TimeInterval) -> SKAction {
    let oldAngle = node.zRotation
    let newAngle = oldAngle + angle
    
    let effect = SKTRotateEffect(node: node, duration: duration, startAngle: newAngle, endAngle: oldAngle)
    effect.timingFunction = SKTCreateShakeFunction(oscillations)

    return SKAction.actionWithEffect(effect)
  }

  public class func screenZoomWithNode(_ node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
    let oldScale = CGPoint(x: node.xScale, y: node.yScale)
    let newScale = oldScale * amount
    
    let effect = SKTScaleEffect(node: node, duration: duration, startScale: newScale, endScale: oldScale)
    effect.timingFunction = SKTCreateShakeFunction(oscillations)

    return SKAction.actionWithEffect(effect)
  }

  public class func colorGlitchWithScene(_ scene: SKScene, originalColor: SKColor, duration: TimeInterval) -> SKAction {
    return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
      if elapsedTime < CGFloat(duration) {
        scene.backgroundColor = SKColorWithRGB(Int.random(0...255), g: Int.random(0...255), b: Int.random(0...255))
      } else {
        scene.backgroundColor = originalColor
      }
    }
  }
}
