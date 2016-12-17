//
//  EditTreatmentPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 17.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class EditTreatmentPageViewController: UIViewController{
        
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    
    let networkingService = NetworkingService()
    let currUser = FIRAuth.auth()?.currentUser

    @IBOutlet weak var medicineNamePicker: UIPickerView!
    @IBOutlet weak var medicineDosageTextField: UITextField!
    
    @IBOutlet weak var medicineFrequencyPicker: UIPickerView!
    
    @IBOutlet weak var saveMedicineInfoButton: UIButton!
    
    @IBOutlet weak var cancelMedicineInfoButton: UIButton!
    
    
    @IBAction func saveMedicineInfoButtonAction(_ sender: Any) {
        let currUser = FIRAuth.auth()?.currentUser
        networkingService.updateMedicineInfo(user: currUser!, name: medicineNamePicker.description, dosage: medicineDosageTextField.text!, frequency: medicineFrequencyPicker.description)
 
        // go to treatment page
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "treatmentPage") as! TreatmentPageViewController
        self.dismiss(animated: false, completion: nil)
        self.present(nextViewController, animated: true)
    }
    
    @IBAction func cancelMedicineInfoButtonAction(_ sender: Any) {
        
        medicineDosageTextField.text = ""
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var pickerDataMed = ["medA", "medB", "medC"]
        //var pickerDataFreq = ["her gün", "haftalık", "aylık"]
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
