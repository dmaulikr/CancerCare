//
//  BloodPopUpViewController.swift
//  CancerCareNew
//
//  Created by SOS Z14-12 on 15/12/16.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class BloodPopUpViewController: UIViewController {
    @IBOutlet weak var rbcTextField: UITextField!
    @IBOutlet weak var wbcTextField: UITextField!
    @IBOutlet weak var ancTextField: UITextField!
    @IBOutlet weak var saveBloodButton: UIButton!
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    let networkingService = NetworkingService()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBloodButtonAction(_ sender: Any) {
        let currUser = FIRAuth.auth()?.currentUser
        networkingService.updateChildBlood(user: currUser!, rbc: self.rbcTextField.text!, wbc: self.wbcTextField.text!, anc: self.ancTextField.text!)
        
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "vitalsPage") as! VitalsViewController
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
