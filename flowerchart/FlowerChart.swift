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
    var petalNumber: Int!
    var totalPetals: Int!
    var maxArcWidth: CGFloat!
    var colorsArray: [UIColor]!
    var petalsArray: [UIView]!
    
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
//            petalsArray.append(petalView)
            petalView.drawPetalHere(i, petalColor: colorsArray[i])
        }
        
        for (var i = 0; i < totalPetals; i++) {
            targetInitialization(i)
            petalInitialization(i)
        }
    }
    
    func drawPetalHere(petalNumber: Int, petalColor: UIColor) {
        
        let pi:CGFloat = CGFloat(M_PI)
        let strokeColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        let isize = min(petalCanvas.bounds.width, petalCanvas.bounds.height)
        let outlineWidth: CGFloat = 1
        let innerRadius: CGFloat = 0
        let arcRadius: CGFloat = isize/4
        let center = CGPoint(x:petalCanvas.bounds.width/2, y: petalCanvas.bounds.height/2)
        let startAngle = CGFloat(0) + CGFloat(petalNumber)*2*pi / CGFloat(totalPetals) - pi/2
        let endAngle = startAngle + 2*pi / CGFloat(totalPetals)
        
        let petalPath = UIBezierPath(arcCenter: center,
            radius:  arcRadius - outlineWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        petalPath.addArcWithCenter(center,
            radius: innerRadius + outlineWidth/2,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: false)
        petalPath.closePath()
        
        petalPath.lineWidth = outlineWidth;
        petalPath.stroke()
        
        let petalShapeLayer: CAShapeLayer = CAShapeLayer()
        petalShapeLayer.path = petalPath.CGPath
        petalShapeLayer.fillColor = petalColor.CGColor
        petalShapeLayer.lineWidth = outlineWidth
        petalShapeLayer.strokeColor = strokeColor.CGColor
        self.layer.addSublayer(petalShapeLayer)
        
    }
    
    func drawMeasures(petalNumber: Int) {
        
        let pi:CGFloat = CGFloat(M_PI)
        let strokeColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        let fillColor: UIColor = UIColor.clearColor()
        
        let isize = min(petalCanvas.bounds.width, petalCanvas.bounds.height)
        let outlineWidth: CGFloat = 1
        let arcRadius: CGFloat = isize/2
        let center = CGPoint(x:petalCanvas.bounds.width/2, y: petalCanvas.bounds.height/2)
        let startAngle = CGFloat(0) + CGFloat(petalNumber)*2*pi / CGFloat(totalPetals) - pi/2
        let endAngle = startAngle + 2*pi / CGFloat(totalPetals)
        
        let midPointAngle = (startAngle + endAngle) / 2.0
        let targetPoint1 = CGPoint(x: center.x + (arcRadius - 20) * cos(midPointAngle), y: center.y + (arcRadius - 20) *  sin(midPointAngle))
        let targetPoint2 = CGPoint(x: center.x + (arcRadius - 40) * cos(midPointAngle), y: center.y + (arcRadius - 40) *  sin(midPointAngle))
        
        let arcPath = UIBezierPath(arcCenter: center,
            radius:  arcRadius,
            startAngle: startAngle + (endAngle - startAngle) / 4,
            endAngle: endAngle - (endAngle - startAngle) / 4,
            clockwise: true)
        arcPath.lineWidth = outlineWidth;
        arcPath.stroke()
        
        let littleLinePath = UIBezierPath()
        littleLinePath.moveToPoint(targetPoint1)
        littleLinePath.addLineToPoint(targetPoint2)
        littleLinePath.closePath()
        littleLinePath.lineWidth = outlineWidth
        littleLinePath.stroke()
        
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

    
}
