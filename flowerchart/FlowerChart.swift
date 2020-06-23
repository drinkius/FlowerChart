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
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func drawFlower(_ colorsArray: [UIColor]) {
        
        let targetCanvas = UIView()
        targetCanvas.frame = petalCanvas.bounds
        petalCanvas.addSubview(targetCanvas)
        
        func targetInitialization(_ i: Int) -> Void {
            let targetView = FlowerChart(petalCanvas: petalCanvas, totalPetals: totalPetals)
            targetView.frame = targetCanvas.bounds
            targetView.drawMeasures(i)
            targetCanvas.addSubview(targetView)
        }
        
        func petalInitialization(_ i: Int) -> Void{
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
    
    func drawPetalHere(_ petalNumber: Int, petalColor: UIColor) {
        
        let pi:CGFloat = CGFloat(Double.pi)
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
        petalPath.addLine(to: center)
        petalPath.close()
        
        let petalShapeLayer: CAShapeLayer = CAShapeLayer()
        petalShapeLayer.path = petalPath.cgPath
        petalShapeLayer.fillColor = petalColor.cgColor
        petalShapeLayer.lineWidth = outlineWidth
        petalShapeLayer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(petalShapeLayer)
        
    }
    
    func drawMeasures(_ petalNumber: Int) {
        
        let pi:CGFloat = CGFloat(Double.pi)
        let strokeColor: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        let fillColor: UIColor = UIColor.clear
        
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
        littleLinePath.move(to: measuresPoint1)
        littleLinePath.addLine(to: measuresPoint2)
        littleLinePath.close()
        
        let arcPathLayer: CAShapeLayer = CAShapeLayer()
        arcPathLayer.path = arcPath.cgPath
        arcPathLayer.fillColor = fillColor.cgColor
        arcPathLayer.lineWidth = outlineWidth
        arcPathLayer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(arcPathLayer)
        
        let littleLinePathLayer: CAShapeLayer = CAShapeLayer()
        littleLinePathLayer.path = littleLinePath.cgPath
        littleLinePathLayer.fillColor = fillColor.cgColor
        littleLinePathLayer.lineWidth = outlineWidth
        littleLinePathLayer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(littleLinePathLayer)
        
    }
    
    func setPetalSizes(_ sizesArray: [Double]) {
        
        for i in petalsArray.indices.suffix(from: 0) {
            
            let scale = CGAffineTransform(scaleX: 0.6, y: 0.6)
            let rotate = CGAffineTransform(rotationAngle: 360)
            let currentDelay = Double(i) / 8
            let petalToSet = petalsArray[i]
            let currentSize = CGFloat(sizesArray[i])
            
            petalToSet.transform = scale.concatenating(rotate)
            petalToSet.alpha = 0
            
            UIView.animate(withDuration: 0.5,
                           delay: currentDelay,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 2,
                           options: UIView.AnimationOptions(),
                           animations: { () -> Void in
                
                let scale = CGAffineTransform(scaleX: currentSize / 10, y: currentSize / 10)
                let rotate = CGAffineTransform(rotationAngle: 0)
                petalToSet.transform = scale.concatenating(rotate)
                petalToSet.alpha = 1
                
                }, completion: { (finished: Bool) -> Void in
            })
        }
    }
    
    func drawCenter(_ centerRadius: CGFloat) {
        
        self.centerRadius = centerRadius
        let centerPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.0 * centerRadius - 10, height: 2.0 * centerRadius - 10), cornerRadius: centerRadius)
        centerPath.close()
        let centerShapeLayer: CAShapeLayer = CAShapeLayer()
        centerShapeLayer.path = centerPath.cgPath
        centerShapeLayer.position = CGPoint(x: petalCanvas.bounds.midX - centerRadius, y: petalCanvas.bounds.midY - centerRadius)
        centerShapeLayer.fillColor = UIColor.white.cgColor
        centerShapeLayer.lineWidth = 1
        centerShapeLayer.strokeColor = UIColor.black.cgColor
        petalCanvas.layer.addSublayer(centerShapeLayer)
        
    }
    
    func displayLabels(_ namesArray: [String]) {
        
        if namesArray.count == totalPetals {
            
            var nameNumber: Double = 1.0
            
            for name in namesArray {
 
                let size = CGSize(width: petalCanvas.bounds.width, height: petalCanvas.bounds.height)
                
                UIGraphicsBeginImageContextWithOptions(size, false, 0)
                
                let context = UIGraphicsGetCurrentContext()!
                // *******************************************************************
                // Scale & translate the context to have 0,0
                // at the centre of the screen maths convention
                // Obviously change your origin to suit...
                // *******************************************************************
                
//                CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
//                CGContextSetLineWidth(context, 10)
                
                context.setFillColor(UIColor.clear.cgColor)
                context.translateBy (x: size.width / 2, y: size.height / 2)
                context.scaleBy (x: 1, y: -1)
                context.setShouldAntialias(true)
                
                centreArcPerpendicularText(name, context: context, radius: petalCanvas.bounds.width / 2 - 4, angle: CGFloat(Double.pi/2 - Double.pi * 2 * (nameNumber - 0.5) / Double(namesArray.count)), colour: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7), font: UIFont.systemFont(ofSize: 8), clockwise: true)
//                centreArcPerpendicularText("Anticlockwise", context: context, radius: 50, angle: CGFloat(-Double.pi/2), colour: UIColor.blackColor(), font: UIFont.systemFontOfSize(16), clockwise: false)
                
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                let labelLayer: CAShapeLayer = CAShapeLayer()
                labelLayer.frame = petalCanvas.bounds
                labelLayer.setNeedsDisplay()
                labelLayer.contents = image?.cgImage
                labelLayer.allowsEdgeAntialiasing = true
                petalCanvas.layer.addSublayer(labelLayer)
                
                nameNumber += 1.0
        
                 print("Width: \(labelLayer.bounds.width) Height: \(labelLayer.bounds.height)")

            }
        }
        
    }
    
    // Code for drawing circular text, curtesy of Grimxn from http://stackoverflow.com/questions/32771864/draw-text-along-circular-path-in-swift-for-ios
    
    func centreArcPerpendicularText(_ str: String, context: CGContext, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, clockwise: Bool){
        // *******************************************************
        // This draws the String str around an arc of radius r,
        // with the text centred at polar angle theta
        // *******************************************************
        
        let l = str.count
        let attributes = [NSAttributedString.Key.font: font]
        
        var characters: [String] = [] // This will be an array of single character strings, each character in str
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            characters += [String(str[str.index(str.startIndex, offsetBy: i)])]
            arcs += [chordToArc(characters[i].size(withAttributes: attributes).width, radius: r)]
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(Double.pi/2) : CGFloat(Double.pi/2)
        
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
    
    func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
        // *******************************************************
        // Simple geometry
        // *******************************************************
        return 2 * asin(chord / (2 * radius))
    }
    
    func centreText(_ str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, slantAngle: CGFloat) {
        // *******************************************************
        // This draws the String str centred at the position
        // specified by the polar coordinates (r, theta)
        // i.e. the x= r * cos(theta) y= r * sin(theta)
        // and rotated by the angle slantAngle
        // *******************************************************
        
        // Set the text attributes
        let attributes = [NSAttributedString.Key.foregroundColor: c,
                          NSAttributedString.Key.font: font]
        // Save the context
        context.saveGState()
        // Undo the inversion of the Y-axis (or the text goes backwards!)
        context.scaleBy(x: 1, y: -1)
        // Move the origin to the centre of the text (negating the y-axis manually)
        context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
        // Rotate the coordinate system
        context.rotate(by: -slantAngle)
        // Calculate the width of the text
        let offset = str.size(withAttributes: attributes)
        // Move the origin by half the size of the text
        context.translateBy (x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        // Draw the text
        str.draw(at: CGPoint.zero, withAttributes: attributes)
        // Restore the context
        context.restoreGState()
    }
    
}
