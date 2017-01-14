//
//  SecondaryAccountViewController.swift
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

class SecondaryAccountViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var registerSecondaryAccountButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let networkingService = NetworkingService()
    let currUser = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.title = "İkincil Hesap"
        self.navigationItem.title = self.navigationController?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createSecondaryAccount(_ sender: UIButton) {
        let name = nameTextField.text
        let surname = surnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = passwordConfirmTextField.text
        let mainUserID = currUser?.uid
        
        //check for empty fields
        if ((name?.isEmpty)! || (surname?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)!){
            //Display alert message
            displayAlertMessage(userMessage: "Tüm alanları doldurunuz.");
            return;
        }
        
        //check if passwords match
        if(password != confirmPassword){
            //Display an alert message
            displayAlertMessage(userMessage: "Şifre aynı değil. Tekrar girin.");
            return;
        }
        
        //Store data
        networkingService.signUp2(name: nameTextField.text!, surname: surnameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, mainUID: mainUserID!)
        
        //Display alert message with confirmation
    }
    
    @IBAction func cancelRegistration(_ sender: UIButton) {
        nameTextField.text = ""
        surnameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordConfirmTextField.text = ""
    }
    
    func displayAlertMessage(userMessage: String){
        
        var myAlert = UIAlertController(title: "Uyarı:", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"Tamam", style: UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordConfirmTextField.endEditing(true)
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
