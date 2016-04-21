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
        
        let maxSize = min(petalCanvas.bounds.width - 20, petalCanvas.bounds.height - 20)
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
        
        let maxSize = min(petalCanvas.bounds.width - 20, petalCanvas.bounds.height - 20)
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
        let centerPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * centerRadius - 10, height: 2.0 * centerRadius - 10), cornerRadius: centerRadius)
        centerPath.closePath()
        let centerShapeLayer: CAShapeLayer = CAShapeLayer()
        centerShapeLayer.path = centerPath.CGPath
        centerShapeLayer.position = CGPoint(x: CGRectGetMidX(petalCanvas.bounds) - centerRadius, y: CGRectGetMidY(petalCanvas.bounds) - centerRadius)
        centerShapeLayer.fillColor = UIColor.whiteColor().CGColor
        centerShapeLayer.lineWidth = 1
        centerShapeLayer.strokeColor = UIColor.blackColor().CGColor
        petalCanvas.layer.addSublayer(centerShapeLayer)
        
    }
    
    func displayLabels(namesArray: [String]) {
        
        if namesArray.count == totalPetals {
            
            var nameNumber: Double = 1.0
            
            for name in namesArray {
 
                let size = CGSizeMake(petalCanvas.bounds.width, petalCanvas.bounds.height)
                
                UIGraphicsBeginImageContextWithOptions(size, false, 0)
                
                let context = UIGraphicsGetCurrentContext()!
                // *******************************************************************
                // Scale & translate the context to have 0,0
                // at the centre of the screen maths convention
                // Obviously change your origin to suit...
                // *******************************************************************
                
//                CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
//                CGContextSetLineWidth(context, 10)
                
                CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
                CGContextTranslateCTM (context, size.width / 2, size.height / 2)
                CGContextScaleCTM (context, 1, -1)
                CGContextSetShouldAntialias(context, true)
                
                centreArcPerpendicularText(name, context: context, radius: petalCanvas.bounds.width / 2 - 4, angle: CGFloat(M_PI_2 - M_PI * 2 * (nameNumber - 0.5) / Double(namesArray.count)), colour: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), font: UIFont.systemFontOfSize(8), clockwise: true)
//                centreArcPerpendicularText("Anticlockwise", context: context, radius: 50, angle: CGFloat(-M_PI_2), colour: UIColor.blackColor(), font: UIFont.systemFontOfSize(16), clockwise: false)
                
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                let labelLayer: CAShapeLayer = CAShapeLayer()
                labelLayer.frame = petalCanvas.bounds
                labelLayer.setNeedsDisplay()
                labelLayer.contents = image.CGImage
                labelLayer.allowsEdgeAntialiasing = true
                petalCanvas.layer.addSublayer(labelLayer)
                
                nameNumber += 1.0
        
                 print("Width: \(labelLayer.bounds.width) Height: \(labelLayer.bounds.height)")

            }
        }
        
    }
    
    // Code for drawing circular text, curtesy of Grimxn from http://stackoverflow.com/questions/32771864/draw-text-along-circular-path-in-swift-for-ios
    
    func centreArcPerpendicularText(str: String, context: CGContextRef, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, clockwise: Bool){
        // *******************************************************
        // This draws the String str around an arc of radius r,
        // with the text centred at polar angle theta
        // *******************************************************
        
        let l = str.characters.count
        let attributes = [NSFontAttributeName: font]
        
        var characters: [String] = [] // This will be an array of single character strings, each character in str
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            characters += [String(str[str.startIndex.advancedBy(i)])]
            arcs += [chordToArc(characters[i].sizeWithAttributes(attributes).width, radius: r)]
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(M_PI_2) : CGFloat(M_PI_2)
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
        var thetaI = theta - direction * totalArc / 2
        
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            // Call centerText with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            centreText(characters[i], context: context, radius: r, angle: thetaI, colour: c, font: font, slantAngle: thetaI + slantCorrection)
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func chordToArc(chord: CGFloat, radius: CGFloat) -> CGFloat {
        // *******************************************************
        // Simple geometry
        // *******************************************************
        return 2 * asin(chord / (2 * radius))
    }
    
    func centreText(str: String, context: CGContextRef, radius r:CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, slantAngle: CGFloat) {
        // *******************************************************
        // This draws the String str centred at the position
        // specified by the polar coordinates (r, theta)
        // i.e. the x= r * cos(theta) y= r * sin(theta)
        // and rotated by the angle slantAngle
        // *******************************************************
        
        // Set the text attributes
        let attributes = [NSForegroundColorAttributeName: c,
                          NSFontAttributeName: font]
        // Save the context
        CGContextSaveGState(context)
        // Undo the inversion of the Y-axis (or the text goes backwards!)
        CGContextScaleCTM(context, 1, -1)
        // Move the origin to the centre of the text (negating the y-axis manually)
        CGContextTranslateCTM(context, r * cos(theta), -(r * sin(theta)))
        // Rotate the coordinate system
        CGContextRotateCTM(context, -slantAngle)
        // Calculate the width of the text
        let offset = str.sizeWithAttributes(attributes)
        // Move the origin by half the size of the text
        CGContextTranslateCTM (context, -offset.width / 2, -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        // Draw the text
        str.drawAtPoint(CGPointZero, withAttributes: attributes)
        // Restore the context
        CGContextRestoreGState(context)
    }
    
}
