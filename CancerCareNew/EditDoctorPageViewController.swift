//
//  EditDoctorPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 17.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditDoctorPageViewController: UIViewController {
    
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    let networkingService = NetworkingService()

    @IBOutlet weak var doctorNameTextField: UITextField!
    
    @IBOutlet weak var doctorMailTextField: UITextField!
    
    @IBOutlet weak var doctorPhoneTextField: UITextField!
    
    @IBOutlet weak var doctorAddressTextField: UITextView!
    
    @IBOutlet weak var saveDoctorInfoButton: UIButton!
    
    @IBOutlet weak var cancelDoctorInfoButton: UIButton!
    
    @IBAction func saveDoctorInfoButtonAction(_ sender: Any) {
        let currUser = FIRAuth.auth()?.currentUser
        let alertMessage = networkingService.updateDoctorInfo(user: currUser!, name: doctorNameTextField.text!, email: doctorMailTextField.text!, phone: doctorPhoneTextField.text!, address: doctorAddressTextField.text!)
        
        displayMessage(alertMessage: alertMessage)
    }
    
    @IBAction func cancelDoctorInfoButtonAction(_ sender: Any) {
        doctorNameTextField.text = ""
        doctorMailTextField.text = ""
        doctorPhoneTextField.text = ""
        doctorAddressTextField.text = ""
    }
    
    func displayMessage(alertMessage: String) {
        
        let alertController = UIAlertController(title: "", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default)
            
        {
            
            (UIAlertAction) -> Void in
            
        }
        
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true)
            
        {
            
            () ->  Void in
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        doctorAddressTextField.endEditing(true)
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
