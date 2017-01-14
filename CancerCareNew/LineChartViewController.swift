//
//  LineChartViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 14.01.2017.
//  Copyright © 2017 FED. All rights reserved.
//

import UIKit
import Charts
import Firebase
import QuartzCore

class LineChartViewController: UIViewController, LineChartDelegate {
    
    let networkRef = NetworkingService()
    let databaseRef = DatabaseAdapter()
    var label = UILabel()
    var lineChart: LineChart!
    var temps = ""
    //let lineChart = LineChart()
    
    public func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        label.text = "x: \(x)     y: \(yValues)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var views: [String: AnyObject] = [:]
        
        label.text = "Vücut Sıcaklığı Değerleri"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        
        
        // simple arrays
        let data: [CGFloat] = [37, 41, 38, 37, 35, 36, 39]
        fetchRecentTemps(){r in
            self.label.text = "Son değerler: " + r
        }
        
        /*
        let tempArr : [String] = temps.components(separatedBy: ",")
        let s1 = tempArr[0]
        let fl1: CGFloat = CGFloat((s1 as NSString).doubleValue)
        let s2 = tempArr[1]
        let fl2: CGFloat = CGFloat((s2 as NSString).doubleValue)
        let s3 = tempArr[2]
        let fl3: CGFloat = CGFloat((s3 as NSString).doubleValue)
        let s4 = tempArr[3]
        let fl4: CGFloat = CGFloat((s4 as NSString).doubleValue)
        let s5 = tempArr[4]
        let fl5: CGFloat = CGFloat((s5 as NSString).doubleValue)
        let s6 = tempArr[5]
        let fl6: CGFloat = CGFloat((s6 as NSString).doubleValue)
        let s7 = tempArr[6]
        let fl7: CGFloat = CGFloat((s7 as NSString).doubleValue)
        */
        //let data: [CGFloat] = [fl1, fl2, fl3, fl4, fl5, fl6, fl7]
        //let data2: [CGFloat] = [1, 3, 5, 13, 17, 20]
        
 
        // simple line with custom x axis labels
        let xLabels: [String] = ["Gün 1", "Gün 2", "Gün 3", "Gün 4", "Gün 5", "Gün 6", "Gün 7"]
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 5
        lineChart.x.labels.values = xLabels
        lineChart.y.labels.visible = true
        lineChart.addLine(data)
        //lineChart.addLine(data2)
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        self.view.addSubview(lineChart)
        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))
    }
    
    /*func addToArray(result: String){
        let tempArr : [String] = result.components(separatedBy: ",")
        let s1 = tempArr[0]
        let fl1: CGFloat = CGFloat((s1 as NSString).doubleValue)
        let s2 = tempArr[1]
        let fl2: CGFloat = CGFloat((s2 as NSString).doubleValue)
        let s3 = tempArr[2]
        let fl3: CGFloat = CGFloat((s3 as NSString).doubleValue)
        let s4 = tempArr[3]
        let fl4: CGFloat = CGFloat((s4 as NSString).doubleValue)
        let s5 = tempArr[4]
        let fl5: CGFloat = CGFloat((s5 as NSString).doubleValue)
        let s6 = tempArr[5]
        let fl6: CGFloat = CGFloat((s6 as NSString).doubleValue)
        let s7 = tempArr[6]
        let fl7: CGFloat = CGFloat((s7 as NSString).doubleValue)
        let data: [CGFloat] = [fl1, fl2, fl3, fl4, fl5, fl6, fl7]
        takeData(data: data)
    }
    */
    
    func fetchRecentTemps(completion: @escaping (String)->Void) {
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        var result = ""
        databaseRef.fetchDict(key: "\(currUserID!)", path: "temperature/"){ resultt in
            var counter = 0
            for k in resultt {
                if (counter < 7){
                    result += k.value as! String + " "
                }
                counter += 1
            }
            completion(result)
        }
    }
}
