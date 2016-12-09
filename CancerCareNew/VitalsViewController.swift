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

class VitalsViewController: UIViewController {

    
    @IBOutlet weak var rbcTextField: UITextField!
    @IBOutlet weak var wbcTextField: UITextField!
    @IBOutlet weak var ancTextField: UITextField!
    
    @IBOutlet weak var tempTextField: UITextField!
    
    let currUser = FIRAuth.auth()?.currentUser
    
    let networkingService = NetworkingService()
    
    @IBAction func addBloodButtonTapped(_ sender: Any) {
        // do stuff
        //let currUser = FIRAuth.auth()?.currentUser
        //let currUserID = currUser?.uid
        //let childRef = databaseRef.child("children").child(currUserID!)
        // childRef.child("childName").setValue(editNameTextfield.text)
        networkingService.updateChildBlood(user: currUser!, rbc: self.rbcTextField.text!, wbc: self.wbcTextField.text!, anc: self.ancTextField.text!)
    }
    
    @IBAction func addTempButtonTapped(_ sender: Any) {
        //let currUser = FIRAuth.auth()?.currentUser
        networkingService.updateChildTemp(user: currUser!, temp: self.tempTextField.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Sağlık Değerleri"
        self.navigationItem.title = self.navigationController?.title


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
