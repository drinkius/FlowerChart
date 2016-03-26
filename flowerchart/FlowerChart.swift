//
//  FlowerChart.swift
//  flowerchart
//
//  Created by drinkius on 22/03/16.
//  Copyright © 2016 Alexander Telegin. All rights reserved.
//

import UIKit

class FlowerChart: UIView {
    
    var petalCanvas: UIView!
    var totalPetals: Int!
    var colorsArray: [UIColor]!
    var petalsArray = [UIView]()
    var centerRadius: CGFloat = 0.0
    
    init(petalCanvas: UIView, totalPetals: Int) {
        self.petalCanvas = petalCanvas
        self.totalPetals = totalPetals
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func drawFlower(colorsArray: [UIColor]) {
        
        let targetCanvas = UIView()
        targetCanvas.frame = petalCanvas.bounds
        petalCanvas.addSubview(targetCanvas)
        
        func targetInitialization(i: Int) -> Void {
            let targetView = FlowerChart(petalCanvas: petalCanvas, totalPetals: totalPetals)
            targetView.frame = targetCanvas.bounds
            targetView.drawMeasures(i)
            targetCanvas.addSubview(targetView)
        }
        
        func petalInitialization(i: Int) -> Void{
            let petalView = FlowerChart(petalCanvas: petalCanvas, totalPetals: totalPetals)
            petalView.frame = petalCanvas.bounds
            petalCanvas.addSubview(petalView)
            petalsArray.append(petalView)
            petalView.drawPetalHere(i, petalColor: colorsArray[i])
        }
        
        for i in 0 ..< totalPetals {
            targetInitialization(i)
            petalInitialization(i)
        }
        
    }
    
    func drawPetalHere(petalNumber: Int, petalColor: UIColor) {
        
        let pi:CGFloat = CGFloat(M_PI)
        let strokeColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        let maxSize = min(petalCanvas.bounds.width, petalCanvas.bounds.height)
        let outlineWidth: CGFloat = 1
        let arcRadius: CGFloat = maxSize/2
        let center = CGPoint(x:petalCanvas.bounds.width/2, y: petalCanvas.bounds.height/2)
        let startAngle = CGFloat(0) + CGFloat(petalNumber)*2*pi / CGFloat(totalPetals) - pi/2
        let endAngle = startAngle + 2*pi / CGFloat(totalPetals)
        
        let petalPath = UIBezierPath(arcCenter: center,
            radius:  arcRadius - outlineWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        petalPath.addLineToPoint(center)
        petalPath.closePath()
        
        let petalShapeLayer: CAShapeLayer = CAShapeLayer()
        petalShapeLayer.path = petalPath.CGPath
        petalShapeLayer.fillColor = petalColor.CGColor
        petalShapeLayer.lineWidth = outlineWidth
        petalShapeLayer.strokeColor = strokeColor.CGColor
        self.layer.addSublayer(petalShapeLayer)
        
    }
    
    func drawMeasures(petalNumber: Int) {
        
        let pi:CGFloat = CGFloat(M_PI)
        let strokeColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        let fillColor: UIColor = UIColor.clearColor()
        
        let maxSize = min(petalCanvas.bounds.width, petalCanvas.bounds.height)
        let outlineWidth: CGFloat = 1
        let arcRadius: CGFloat = maxSize/2
        let center = CGPoint(x:petalCanvas.bounds.width/2, y: petalCanvas.bounds.height/2)
        let startAngle = CGFloat(0) + CGFloat(petalNumber)*2*pi / CGFloat(totalPetals) - pi/2
        let endAngle = startAngle + 2*pi / CGFloat(totalPetals)
        
        let midPointAngle = (startAngle + endAngle) / 2.0
        let measuresPoint1 = CGPoint(x: center.x + (arcRadius - 20) * cos(midPointAngle), y: center.y + (arcRadius - 20) *  sin(midPointAngle))
        let measuresPoint2 = CGPoint(x: center.x + (arcRadius - 40) * cos(midPointAngle), y: center.y + (arcRadius - 40) *  sin(midPointAngle))
        
        let arcPath = UIBezierPath(arcCenter: center,
            radius:  arcRadius,
            startAngle: startAngle + (endAngle - startAngle) / 4,
            endAngle: endAngle - (endAngle - startAngle) / 4,
            clockwise: true)
        arcPath.lineWidth = outlineWidth;
        arcPath.stroke()
        
        let littleLinePath = UIBezierPath()
        littleLinePath.moveToPoint(measuresPoint1)
        littleLinePath.addLineToPoint(measuresPoint2)
        littleLinePath.closePath()
        
        let arcPathLayer: CAShapeLayer = CAShapeLayer()
        arcPathLayer.path = arcPath.CGPath
        arcPathLayer.fillColor = fillColor.CGColor
        arcPathLayer.lineWidth = outlineWidth
        arcPathLayer.strokeColor = strokeColor.CGColor
        self.layer.addSublayer(arcPathLayer)
        
        let littleLinePathLayer: CAShapeLayer = CAShapeLayer()
        littleLinePathLayer.path = littleLinePath.CGPath
        littleLinePathLayer.fillColor = fillColor.CGColor
        littleLinePathLayer.lineWidth = outlineWidth
        littleLinePathLayer.strokeColor = strokeColor.CGColor
        self.layer.addSublayer(littleLinePathLayer)
        
    }
    
    func setPetalSizes(sizesArray: [Double]) {
        
        for i in 0 ..< petalsArray.endIndex {
            
            let scale = CGAffineTransformMakeScale(0.6, 0.6)
            let rotate = CGAffineTransformMakeRotation(360)
            let currentDelay = Double(i) / 8
            let petalToSet = petalsArray[i]
            let currentSize = CGFloat(sizesArray[i])
            
            petalToSet.transform = CGAffineTransformConcat(scale, rotate)
            petalToSet.alpha = 0
            
            UIView.animateWithDuration(0.5, delay: currentDelay, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                
                let scale = CGAffineTransformMakeScale(currentSize / 10, currentSize / 10)
                let rotate = CGAffineTransformMakeRotation(0)
                petalToSet.transform = CGAffineTransformConcat(scale, rotate)
                petalToSet.alpha = 1
                
                }, completion: { (finished: Bool) -> Void in
            })
        }
    }
    
    func drawCenter(centerRadius: CGFloat) {
        
        self.centerRadius = centerRadius
        let centerPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * centerRadius, height: 2.0 * centerRadius), cornerRadius: centerRadius)
        centerPath.closePath()
        let centerShapeLayer: CAShapeLayer = CAShapeLayer()
        centerShapeLayer.path = centerPath.CGPath
        centerShapeLayer.position = CGPoint(x: CGRectGetMidX(petalCanvas.bounds) - centerRadius, y: CGRectGetMidY(petalCanvas.bounds) - centerRadius)
        centerShapeLayer.fillColor = UIColor.whiteColor().CGColor
        centerShapeLayer.lineWidth = 1
        centerShapeLayer.strokeColor = UIColor.blackColor().CGColor
        petalCanvas.layer.addSublayer(centerShapeLayer)
        
    }
    
}
