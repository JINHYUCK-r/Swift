//
//  FaceView.swift
//  FaceIt
//
//  Created by 류진혁 on 2021/07/02.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var scale : CGFloat = 0.90{ didSet{ setNeedsDisplay()}} // 화면을 새로그릴때 사용
    @IBInspectable
    var mouthCuvature : Double = 1.0 { didSet{ setNeedsDisplay()}}// 1은 웃는얼굴 -1은 찡그린 얼굴
    @IBInspectable
    var eyesOpen : Bool = false { didSet{ setNeedsDisplay()}}
    @IBInspectable
    var eyeBrowTilt : Double = -0.5{ didSet{ setNeedsDisplay()}}// -1 찡그린얼굴
    @IBInspectable
    var color : UIColor = UIColor.blue{ didSet{ setNeedsDisplay()}}
    @IBInspectable
    var lineWidth : CGFloat = 5.0{ didSet{ setNeedsDisplay()}}
    
    
    var skullRadius :CGFloat{
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    var skullCenter :CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
  
    private struct Ratios{
        static let SkullRadiusToEyeOffset : CGFloat = 3
        static let SkullRadiusToEyeRadius : CGFloat = 10
        static let SkullRadiusToMouthWidth : CGFloat = 1
        static let SkullRadiusToMouthHeight : CGFloat = 3
        static let SkullRadiusToMouthOffset : CGFloat = 3
        static let SkullRadiusToBrowOffset : CGFloat = 5
    }
    
    enum Eye{
        case Left
        case Right
    }
    func pathForSircleCenteredAtPoint(midPoint : CGPoint , widthRadius radius : CGFloat) -> UIBezierPath{
        let path =   UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = lineWidth
        return path
    }
    
    private func getEyeCenter(eye : Eye) -> CGPoint{
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:
            eyeCenter.x -= eyeOffset
        case .Right:
            eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye : Eye) -> UIBezierPath{
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        if eyesOpen {
            return pathForSircleCenteredAtPoint(midPoint: eyeCenter, widthRadius: eyeRadius)
        } else{
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
     
    }
    
   
    private func pathForBrow(eye : Eye) -> UIBezierPath{
        var tilt = eyeBrowTilt
     
        switch eye {
        case .Left:
            tilt *= -1.0
        case .Right:
            break
        }
        var browCenter = getEyeCenter(eye: eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1,min(tilt, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
        
    }
    
    
    private func pathForMouth() -> UIBezierPath{
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
       // return UIBezierPath(rect: mouthRect)
        
       
        let smileOffset = CGFloat(max(-1, min(mouthCuvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForSircleCenteredAtPoint(midPoint: skullCenter, widthRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
        pathForBrow(eye: .Left).stroke()
        pathForBrow(eye: .Right).stroke()
    }
   

}
