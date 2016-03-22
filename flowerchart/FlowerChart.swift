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
    
    init(petalCanvas: UIView, totalPetals: Int,  petalNumber: Int = 99) {
        self.petalCanvas = petalCanvas
        self.petalNumber = petalNumber
        self.totalPetals = totalPetals
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
