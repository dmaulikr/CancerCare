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
import UIKit.UIPickerView


class EditTreatmentPageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var pickerDataMed = ["medA", "medB", "medC"]
    var pickerDataFreq = ["her gün", "haftalık", "aylık"]
    
        
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
        
        self.present(nextViewController, animated: true)    }
    
    @IBAction func cancelMedicineInfoButtonAction(_ sender: Any) {
        
        medicineDosageTextField.text = ""
        
    }
    
    //var pickerDataMed = ["medA", "medB", "medC"]
    
    //var pickerDataFreq = ["her gün", "haftalık", "aylık"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pickerDataMed = ["medA", "medB", "medC"]
        //pickerDataFreq = ["her gün", "haftalık", "aylık"]
        
        medicineNamePicker.delegate = self
        
        medicineNamePicker.dataSource = self
        
        medicineFrequencyPicker.delegate = self
        
        medicineFrequencyPicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data BURDA Bİ BOKLUK VAR
    
   func pickerView(_ pickerView : UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView.tag == 1){
            
            return pickerDataMed.count
            
        }else{
            
            return pickerDataFreq.count
            
        }
        
    }
    
   
    
    
    // The data to return for the row and component (column) that's being passed in
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return pickerDataMed[row]
        }
        else {
            return pickerDataFreq[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    

 
    
   /* NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //NSLog(@"Component_1: %d",pickerView.tag);
    if (pickerView.tag == 1){
    return [self.arrOpponentTeams count];
    }else if{ (pickerView.tag == 2)
    return [self.arrMyTeams count];
    }else{
    return [self.arrPlayers count];
    }
    
    (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //NSLog(@"Component_2: %d",pickerView.tag);
    if( pickerView.tag == 1 ){
    return [self.arrOpponentTeams objectAtIndex:row];
    }else if{ (pickerView.tag == 2)
    return [self.arrMyTeams objectAtIndex:row];
    }else{
    return [self.arrPlayers objectAtIndex:row];
    }
}
}*/
}

