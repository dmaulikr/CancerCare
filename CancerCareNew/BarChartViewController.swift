//
//  BarChartViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 22.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Charts
import Firebase


class BarChartViewController: UIViewController, ChartViewDelegate {
    
    let user = User()
    let database = DatabaseAdapter()
    
    
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let currDateKey =
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        var result = ""
        database.fetchDict(key: currUserID.childByAutoId(), path: "vitals/"){ resultt in
            for k in resultt {
                if (k.key == currDateKey){
                    result = "Bugünkü etkinlik \(k.value)"
                }
            }
            completion(result)
        }
        */
        let labels = ["3 Week", "2 Week", "Last Week", "This Week"]
        let myScores = [85, 90, 95, 80]
        let groupScores = [90, 91, 90, 91]
        
        
        var myDataEntries : [BarChartDataEntry] = []
        var groupDataEntries : [BarChartDataEntry] = []
        
        for i in 0..<labels.count {
            var currLabel = labels[i]
            let dataEntry1 = BarChartDataEntry(x: Double(i), yValues: [Double(myScores[i])], label: currLabel) //labels[i]
            myDataEntries.append(dataEntry1)
            let dataEntry2 = BarChartDataEntry(x: Double(i + 20), yValues: [Double(groupScores[i])])
            groupDataEntries.append(dataEntry2)
        }
        
        
        
        let chartDataSetMine = BarChartDataSet(values: myDataEntries, label: "RBC Sayımı")
        chartDataSetMine.colors = [UIColor.red]
        
        let chartDataSetGroup = BarChartDataSet(values: groupDataEntries, label: "WBC Sayımı")
        chartDataSetGroup.colors = [UIColor.blue]
        
        var dataSet : [BarChartDataSet] = []
        dataSet.append(chartDataSetMine)
        dataSet.append(chartDataSetGroup)
        
        chartDataSetGroup.drawValuesEnabled = false
        
        
        
        
        barChart.fitBars = true
        
        let data = BarChartData(dataSets: dataSet)
        
        
        data.barWidth = 1.5
        data.groupBars(fromX: 0.1, groupSpace: 0.6, barSpace: 0.9)
        
        barChart.animate(xAxisDuration: 2.0)
        barChart.xAxis.centerAxisLabelsEnabled = true
        
        barChart.animate(yAxisDuration: 2.0)
        
        
        barChart.data = data
        
        barChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChart.xAxis.drawLabelsEnabled = true //true
        
        barChart.rightAxis.enabled = false
        barChart.leftAxis.enabled = false
        
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.drawAxisLineEnabled = false
        //historyView.xAxis.drawLabelsEnabled = false
        
        let disAccess = barChart.xAxis
        
        disAccess.forceLabelsEnabled = true // true

}
}
