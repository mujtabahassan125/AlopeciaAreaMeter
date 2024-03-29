//
//  GraphViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 26/03/2024.
//

import UIKit
import Charts

class GraphViewCell: UITableViewCell {

    @IBOutlet weak var chartView: LineChartView!
    
    let dataEntries: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 3.2),
        ChartDataEntry(x: 1.2, y: 1.7),
        ChartDataEntry(x: 1.4, y: 2.7)
    ]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupChart() {
    

        // Create a dataset for the scatter plot
        let dataSet = LineChartDataSet(entries: dataEntries, label: "")
        dataSet.setColor(ColorConstants.primary) // Set the color to blue
        //  dataSet.sha = .circle // Set the shape to circle
      //  dataSet.scatterShapeHoleRadius = 2
//        dataSet.scatterShapeSize = 5.0 // Set the size of the circle
//        dataSet.setScatterShape(.circle)
//        dataSet.scatterShapeHoleColor = NSUIColor.white
//        dataSet.scatterShapeSize = 5
        dataSet.setCircleColor(ColorConstants.primary) // Set the circle color to blue
           dataSet.circleRadius = 5.0 // Set the radius of the plotted points
           dataSet.circleHoleRadius = 2.5 // Set the hole radius of the plotted points
           dataSet.mode = .linear // Set mode to draw lines between points
           dataSet.drawCircleHoleEnabled = false // Draw hole inside circles
      //  dataSet.setColors(arr, alpha: 1)
      //  dataSet.scatterShapeHoleRadius = 2
        dataSet.drawIconsEnabled = true
        
        // Combine the data sets if you have multiple sets
        let data = LineChartData(dataSets: [dataSet])

        chartView.isUserInteractionEnabled = true
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
       // chartView.delegate = self
        chartView.data = data
         chartView.legend.enabled = false
        chartView.data?.setDrawValues(true)
        chartView.chartDescription.text = nil
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.rightAxis.enabled = true
        chartView.rightAxis.drawLabelsEnabled = false // Hide labels on the right axis
        chartView.rightAxis.gridLineDashLengths = [1, 1]
        
      //  chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        chartView.xAxis.labelPosition = .bottom
        //        chartView.xAxis.axisMaximum = 30
        //        chartView.xAxis.axisMinimum = 1
        //        chartView.xAxis.centerAxisLabelsEnabled = true
        chartView.leftAxis.labelPosition = .outsideChart
    
        
      //  chartView.xAxis.axisLineColor = NSUIColor.lightGray
     //   chartView.leftAxis.axisLineColor = NSUIColor.lightGray
        //chartView.xAxis.axisLineWidth = 2.0
       // chartView.leftAxis.axisLineWidth = 2.0
        
        
    }
    
}
