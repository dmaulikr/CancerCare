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
        networkingService.updateDoctorInfo(user: currUser!, name: doctorNameTextField.text!, email: doctorMailTextField.text!, phone: doctorPhoneTextField.text!, address: doctorAddressTextField.text!)
        
        // go to doctor page
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "doctorPage") as! DoctorPageViewController
        self.dismiss(animated: false, completion: nil)
        self.present(nextViewController, animated: true)
        

    }
    
    @IBAction func cancelDoctorInfoButtonAction(_ sender: Any) {
        doctorNameTextField.text = ""
        doctorMailTextField.text = ""
        doctorPhoneTextField.text = ""
        doctorAddressTextField.text = ""

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
