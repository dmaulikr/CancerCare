//
//  RegisterPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 25.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)

    let networkingService = NetworkingService()
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let name = nameTextField.text
        let surname = surnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        
        //check for empty fields
        if ((name?.isEmpty)! || (surname?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)!){
        
        
            //Display alert message
            
            displayAlertMessage(userMessage: "Tüm alanları doldurunuz.");
            
            return;
        }
        
        //check if passwords match
        if(password != confirmPassword){
            
            //Display an alert msg
            displayAlertMessage(userMessage: "Şifre aynı değil. Tekrar girin.");
            
            return;
        }
        
        
        //Store data
        networkingService.signUp(name: nameTextField.text!, surname: surnameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        
        //Display alert message with confirmation
        
        
    }
    
    func displayAlertMessage(userMessage: String){
        
        
        var myAlert = UIAlertController(title: "Uyarı:", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Tamam", style: UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
        self.present(nextViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
