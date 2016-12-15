//
//  LogoutViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 26.11.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase

class LogoutViewController: UIViewController {
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)

    @IBOutlet weak var exitQuestionLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var cancelLogOutButton: UIButton!
    
    @IBAction func logoutTap(_ sender: UIButton) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
                self.present(nextViewController, animated: true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelLogOutTapped(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
        self.dismiss(animated: false, completion: nil)
        self.present(nextViewController, animated: true)

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Çıkış Yap"
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
