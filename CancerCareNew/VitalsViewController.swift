//
//  VitalsViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Charts

class VitalsViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //let currUser = FIRAuth.auth()?.currentUser
    //let networkingService = NetworkingService()
    @IBOutlet weak var addBloodCountButton: UIButton!
    @IBOutlet weak var addTempCountButton: UIButton!
    @IBOutlet weak var addReportButton: UIButton!
  
    @IBOutlet weak var showBloodGraphButton: UIButton!
    
    @IBOutlet weak var showTempGraphButton: UIButton!
    
    
    @IBAction func showBloodGraphButtonAction(_ sender: Any) {
        
        let vcName = "barChartViewPage"
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
    @IBAction func showTempGraphButtonAction(_ sender: Any) {
        let vcName = "lineChartViewPage"
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.title = "Sağlık Değerleri"
        self.navigationItem.title = self.navigationController?.title
                
    }
    
    /*func viewWillAppear() {
        let chart = BarChartView(frame: self.view.frame)
        let yVals: [Double] = [ 873, 568, 937, 726, 696, 687, 180, 389, 90, 928, 890, 437]
        var entries = [ BarChartDataEntry]()
        for (i, v) in yVals.enumerated() {
            let entry = BarChartDataEntry()
            entry.x = Double( i)
            entry.y = v
            
            entries.append( entry)
        }
        let set = BarChartDataSet( values: entries, label: "Bar Chart")
        let data = BarChartData( dataSet: set)
        chart.data = data
        // no data text
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = false
        self.view.addSubview( chart)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBloodButtonAction(_ sender: Any) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tempPopUp")
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = (sender as! UIView)
        popController.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        self.present(popController, animated: true, completion: nil)
    }

    @IBAction func addTempButtonAction(_ sender: Any) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bloodPopUp")
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = (sender as! UIView)
        popController.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        self.present(popController, animated: true, completion: nil)
    }
    
    @IBAction func addReportButtonAction(_ sender: Any) {
        let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "reportPopUp")
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = (sender as! UIView)
        popController.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        self.present(popController, animated: true, completion: nil)
      
    }
    
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
        
}
