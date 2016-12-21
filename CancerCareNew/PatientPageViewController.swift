//
//  PatientPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PatientPageViewController: UIViewController {
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var surnameTextField: UILabel!
    @IBOutlet weak var birthdateTextField: UILabel!
    @IBOutlet weak var diagnosisTextField: UILabel!
    @IBOutlet weak var diagnosisDateTextField: UILabel!
    @IBOutlet weak var treatmentLocation: UILabel!
    @IBOutlet weak var treatmentType: UILabel!
    @IBOutlet weak var editPatientInfoButton: UIButton!
    
   
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    let networkingService = NetworkingService()
    let currUser = FIRAuth.auth()?.currentUser


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Çocuğum"
        self.navigationItem.title = self.navigationController?.title
        
        let currUserID = currUser?.uid
        databaseRef.child("children").child(currUserID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String?
            let surname = value?["surname"] as? String?
            let birthDate = value?["birthDate"] as? String?
            let diagnosis = value?["diagnosis"] as? String?
            let diagnosisDate = value?["diagnosisDate"] as? String?
            let treatmentLocation = value?["treatmentLocation"] as? String?
            let treatmentType = value?["treatmentType"] as? String?
            
            self.nameTextField.text = name!
            self.surnameTextField.text = surname!
            self.birthdateTextField.text = birthDate!
            self.diagnosisTextField.text = diagnosis!
            self.diagnosisDateTextField.text = diagnosisDate!
            self.treatmentLocation.text = treatmentLocation!
            self.treatmentType.text = treatmentType!
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPatientInfoButtonAction(_ sender: Any) {
        let vcName = "editPatientInfoPage"
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        
        self.navigationController?.pushViewController(viewController!, animated: true)    }
    
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
