//
//  LoginViewController.swift
//  CancerCareNew
//
//  Created by SOS Z14-12 on 26/11/16.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    var storyboardRefForLogin = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let nextViewController = storyboardRefForLogin.instantiateViewController(withIdentifier: "registerPage") as! RegisterPageViewController
        self.present(nextViewController, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter email and password", preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (UIAlertAction) -> Void in
            }
            
            alertController.addAction(defaultAction)
            present(alertController, animated: true)
            {
                () ->  Void in
            }
            
            // self.presentedViewController(defaultAction)
            
        } else {
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if error == nil
                {
                    //self.logoutButton.alpha = 1.0
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    let nextViewController = self.storyboardRefForLogin.instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
                    self.present(nextViewController, animated: true)
                }
                else
                {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    {
                        (UIAlertAction) -> Void in
                    }
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true)
                    {
                        () ->  Void in
                    }
                }
            })
        }
        
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
