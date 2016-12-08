//
//  EditPatientInfoViewController.swift
//  CancerCareNew
//
//  Created by Bihter Yalta on 27.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class EditPatientInfoViewController: UIViewController {

    @IBOutlet weak var editNameTextField: UITextField!
    @IBOutlet weak var editSurnameTextField: UITextField!
    @IBOutlet weak var editBirthDateTextField: UITextField!
    @IBOutlet weak var editDiagnosisTextField: UITextField!
    @IBOutlet weak var editDiagnosisDateTextField: UITextField!
    @IBOutlet weak var editTreatmentLocationTextField: UITextField!
    @IBOutlet weak var editTreatmentTypeTextField: UITextField!
    @IBOutlet weak var confirmPatientInfoButton: UIButton!
    @IBOutlet weak var cancelPatientInfoButton: UIButton!
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    let networkingService = NetworkingService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmPatientInfoButtonAction(_ sender: Any) {
        // do stuff
        let currUser = FIRAuth.auth()?.currentUser
        //let currUserID = currUser?.uid
        //let childRef = databaseRef.child("children").child(currUserID!)
        // childRef.child("childName").setValue(editNameTextfield.text)
        networkingService.updateChildInfo(user: currUser!, name: self.editNameTextField.text!, surname: self.editSurnameTextField.text!, birthDate: self.editBirthDateTextField.text!, diagnosis: self.editDiagnosisTextField.text!, diagnosisDate: self.editDiagnosisDateTextField.text!, treatmentLocation: self.editTreatmentLocationTextField.text!, treatmentType: self.editTreatmentTypeTextField.text!)
        
        // go patient page
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "patientPage") as! PatientPageViewController
        self.dismiss(animated: false, completion: nil)
        self.present(nextViewController, animated: true)

        
    }
    

    @IBAction func cancelPatientInfoButtonAction(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "patientPage") as! PatientPageViewController
        self.dismiss(animated: false, completion: nil)
        self.present(nextViewController, animated: true)
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
