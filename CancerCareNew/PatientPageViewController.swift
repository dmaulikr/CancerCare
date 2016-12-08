//
//  PatientPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit

class PatientPageViewController: UIViewController {
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var surnameTextField: UILabel!
    @IBOutlet weak var birthdateTextField: UILabel!
    @IBOutlet weak var diagnosisTextField: UILabel!
    @IBOutlet weak var diagnosisDateTextField: UILabel!
    @IBOutlet weak var treatmentLocation: UILabel!
    @IBOutlet weak var treatmentType: UILabel!
    @IBOutlet weak var editPatientInfoButton: UIButton!
    @IBOutlet weak var doctorInfoButton: UIButton!
    @IBOutlet weak var doctorNameTextField: UITextField!
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Çocuğum"
        self.navigationItem.title = self.navigationController?.title

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPatientInfoButtonAction(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "editPatientInfoPage") as! EditPatientInfoViewController
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func doctorInfoButtonAction(_ sender: Any) {
        // create doctor page and do stuff
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
