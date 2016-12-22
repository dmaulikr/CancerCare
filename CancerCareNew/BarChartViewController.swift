//
//  BarChartViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 22.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    var x : [Double] = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    let months = ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"]
    var dataSet: [Double] = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart(dataPoints: months, values: dataSet, xvalues: x)
        
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setChart(dataPoints: [String], values: [Double], xvalues: [Double]) {
        barChartView.noDataText = "Kan grafiği için henüz veri girilmemiş."
        barChartView.chartDescription?.text = ""
        
        var dataEntries: [BarChartDataEntry] = []
        print("Fucjdskdfkdşsl")
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry.init(x: xvalues[i], yValues: [values[i]], label: dataPoints[i])
            dataEntries.append(dataEntry)
            
            print("Shitsigfdfdgk")
            
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Kan Değerleri")
        let chartdata = BarChartData.init(dataSets: (chartDataSet as IChartDataSet) as? [IChartDataSet])
        barChartView.data = chartdata//barData?.addDataSet(chartDataSet)// = chartdata//.data = chartdata
        chartDataSet.colors = ChartColorTemplates.colorful()
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        
    }
    

}
