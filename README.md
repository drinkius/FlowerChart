# FlowerChart - custom chart written in Swift 
> Fully vector flower-shaped chart written in Swift

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

Flower-shaped chart written in Swift, this repo is a sample project you can build directly on your iPhone. The charts generated are fully vector and scale without any rasterization and annying pixels. Part of the [Awesome iOS](https://github.com/vsouza/awesome-ios) curated list. 


The chart itself looks as follows:

![alt tag](https://raw.githubusercontent.com/drinkius/flowerchart/master/screenshot.png)

## Features

- [x] Fully vector petals, well adjusted to any screen size
- [x] Supports any number of petals
- [x] All petals can be color-coded

## Requirements

- iOS 8.0+
- Xcode 9

## Installation & usage

#### Manually
1. Download and drop ```FlowerChart.swift``` in your project.  
2. Congratulations, you are all set!  

## Usage example

You can set arbitrary number of "petals" for the flower while creating an instance of the **FlowerChart** class, draw the flower itself with **drawFlower** method (providing an array of UIColors for petals to look the way you like) and set sizes to them using the **setPetalSizes** method. Size for each petal has to be a Double 0.0 ..< 10.0 (no failsafe check in place yet, to be added in future releases). In the sample project there is a Refresh button that generates random sizes for all the petals to show how the chart might look like.

To use flower charts in your own project - just add the FlowerChart.swift file to it. You'd need a pre-set **UIView** which will serve as a canvas for the chart to appear on (just create a basic outlet for it), it's auto-fitted inside the view so no restrictions on its layout.

In the ViewController you need the following properties:

    var flowerChart: FlowerChart!
    var sizesArray = [Double]()
    var colorsArray = [UIColor]()
    let totalPetals = 9 // Set any number of petals you need

Ensure **sizesArray** and **colorsArray** contain necessary amount of elements to draw the number of petals you need. Create an instance of **FlowerChart** class on **viewDidAppear** and set it up in just 4 lines of code:

    let flowerChart = FlowerChart(petalCanvas: petalCanvas, totalPetals: totalPetals)
    self.flowerChart = flowerChart
    flowerChart.drawFlower(colorsArray)
    flowerChart.setPetalSizes(sizesArray)

## Release History

* 0.1.0
    * The first release, current version

## Contribute

We would love for you to contribute to **Flowerchart**, check the ``LICENSE`` file for more info.

## Meta

Alexander Telegin – [@drinkius](https://twitter.com/drinkius) – telegin.alexander@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

https://github.com/drinkius/flowerchart

Good luck and feel free to report any issues, I'll fix them shortly!

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
