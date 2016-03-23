//
//  ViewController.swift
//  flowerchart
//
//  Created by drinkius on 21/03/16.
//  Copyright © 2016 Alexander Telegin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flowerChart: FlowerChart!
    var sizesArray = [Double]()
    var colorsArray = [UIColor]()
    let totalPetals = 9
    
    @IBOutlet weak var petalCanvas: UIView!
    @IBAction func refreshFlower(sender: AnyObject) {
        
        if sizesArray.count > 0 {
            sizesArray.removeAll()
            for _ in 0 ..< totalPetals {
                let size = Double(arc4random_uniform(UInt32(11)))
                sizesArray.append(size)
            }

            } else {
            for _ in 0 ..< totalPetals {
                let size = Double(arc4random_uniform(UInt32(11)))
                sizesArray.append(size)
            }
        }
        
        flowerChart.setPetalSizes(sizesArray)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        colorsArray.append(UIColor(red: 255/255, green: 233/255, blue: 0/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 226/255, green: 3/255, blue: 29/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 255/255, green: 40/255, blue: 51/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 60/255, green: 220/255, blue: 1/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 116/255, green: 237/255, blue: 0/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 164/255, green: 255/255, blue: 4/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 4/255, green: 225/255, blue: 235/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 4/255, green: 230/255, blue: 230/255, alpha: 0.99))
        colorsArray.append(UIColor(red: 4/255, green: 250/255, blue: 225/255, alpha: 0.99))
        
        sizesArray.append(1.0)
        sizesArray.append(10.0)
        sizesArray.append(1.0)
        sizesArray.append(1.0)
        sizesArray.append(10.0)
        sizesArray.append(1.0)
        sizesArray.append(1.0)
        sizesArray.append(10.0)
        sizesArray.append(1.0)
        
        let flowerChart = FlowerChart(petalCanvas: petalCanvas, totalPetals: totalPetals)
        self.flowerChart = flowerChart
        flowerChart.drawFlower(colorsArray)
        flowerChart.setPetalSizes(sizesArray)
        
    }

}

