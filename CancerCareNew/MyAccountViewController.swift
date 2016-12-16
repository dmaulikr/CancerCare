//
//  MyAccountViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase

class MyAccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let networkingService = NetworkingService()
    let currUser = FIRAuth.auth()?.currentUser
    let user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Hesabım"
        self.navigationItem.title = self.navigationController?.title

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonAction(_ sender: Any) {
       user.update(name: nameTextField.text!, surname: surnameTextField.text!, password: oldPasswordTextField.text!, newPassword: newPasswordTextField.text!, confirmNewPassword: confirmNewPasswordTextField.text!)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        nameTextField.text = ""
        surnameTextField.text = ""
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmNewPasswordTextField.text = ""
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
