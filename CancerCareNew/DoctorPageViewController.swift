//
//  DoctorPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 17.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit


class DoctorPageViewController: UIViewController {
    
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    
    @IBOutlet weak var doctorMailLabel: UILabel!
    
    @IBOutlet weak var doctorPhoneLabel: UILabel!
    
    @IBOutlet weak var doctorAddressLabel: UILabel!
    
    @IBOutlet weak var editDoctorInfoButton: UIButton!
    
    @IBAction func editDoctorInfoButtonAction(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "editDoctorPage") as! EditDoctorPageViewController
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
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
