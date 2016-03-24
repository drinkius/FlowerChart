# FlowerChart - custom chart written in Swift 

Flower-shaped chart written in Swift, this repo is a sample project you can build directly on your iPhone. The charts generated are fully vector and scale without any rasterization and annying pixels.

The chart itself looks as follows:

![alt tag](https://raw.githubusercontent.com/drinkius/flowerchart/master/screenshot.png)

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

Good luck and feel free to report any issues, I'll fix them shortly!

