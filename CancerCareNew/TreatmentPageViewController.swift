//
//  TreatmentPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 17.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit


class TreatmentPageViewController: UIViewController {
    
    
    
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    

    @IBOutlet weak var addMedicineButton: UIButton!
    
    @IBAction func addMedicineButtonAction(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "editTreatmentPage") as! EditTreatmentPageViewController
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
