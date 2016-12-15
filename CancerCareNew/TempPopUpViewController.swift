//
//  TempPopUpViewController.swift
//  CancerCareNew
//
//  Created by SOS Z14-12 on 15/12/16.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TempPopUpViewController: UIViewController {

    @IBOutlet weak var tempTextField: UITextField!
    @IBOutlet weak var saveTempButton: UIButton!
    
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

    @IBAction func saveTempButtonAction(_ sender: Any) {
        let currUser = FIRAuth.auth()?.currentUser
        networkingService.updateChildTemp(user: currUser!, temp: self.tempTextField.text!)
        
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
