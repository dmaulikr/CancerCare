//
//  DoctorPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 17.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase



class DoctorPageViewController: UIViewController {
    
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    let currUserID = FIRAuth.auth()?.currentUser?.uid
    let database = DatabaseAdapter()
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    
    @IBOutlet weak var doctorMailLabel: UILabel!
    
    @IBOutlet weak var doctorPhoneLabel: UILabel!
    
    @IBOutlet weak var doctorAddressLabel: UILabel!
    
    @IBOutlet weak var editDoctorInfoButton: UIButton!
    
    @IBAction func editDoctorInfoButtonAction(_ sender: Any) {
        let vcName = "editDoctorPage"
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func displayDoctorName(completion: @escaping (String)->Void){
        
        var result = ""
        
        database.fetchDict(key: "\(currUserID!)", path: "doctors/"){ resultt in
            
            let nameKey = "name"
            
            for k in resultt {
                
                if (k.key == nameKey){
                    
                    result = "\(k.value)"
                    
                }
                
            }
            
            completion(result)
            
        }
        
    }
    
    
    
    func displayDoctorEmail(completion: @escaping (String)->Void){
        
        var result = ""
        
        database.fetchDict(key: "\(currUserID!)", path: "doctors/"){ resultt in
            
            let nameKey = "email"
            
            for k in resultt {
                
                if (k.key == nameKey){
                    
                    result = "\(k.value)"
                    
                }
                
            }
            
            completion(result)
            
        }
        
    }
    
    
    
    func displayDoctorAddress(completion: @escaping (String)->Void){
        
        var result = ""
        
        database.fetchDict(key: "\(currUserID!)", path: "doctors/"){ resultt in
            
            let nameKey = "address"
            
            for k in resultt {
                
                if (k.key == nameKey){
                    
                    result = "\(k.value)"
                    
                }
                
            }
            
            completion(result)
            
        }
        
    }
    
    
    
    func displayDoctorPhone(completion: @escaping (String)->Void){
        
        var result = ""
        
        database.fetchDict(key: "\(currUserID!)", path: "doctors/"){ resultt in
            
            let nameKey = "phone"
            
            for k in resultt {
                
                if (k.key == nameKey){
                    
                    result = "\(k.value)"
                    
                }
                
            }
            
            completion(result)
            
        }
        
    }
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.title = "Doktorum"
        
        self.navigationItem.title = self.navigationController?.title
        
        self.doctorNameLabel.text = "⌛️"
        
        self.doctorMailLabel.text = "⌛️"
        
        self.doctorPhoneLabel.text = "⌛️"
        
        self.doctorAddressLabel.text = "⌛️"
        
        // Do any additional setup after loading the view.
        
        displayDoctorName(){r in
            
            self.doctorNameLabel.text = r
            
        }
        
        displayDoctorEmail(){r in
            
            self.doctorMailLabel.text = r
            
        }
        
        displayDoctorAddress(){r in
            
            self.doctorAddressLabel.text = r
            
        }
        
        displayDoctorPhone(){r in
            
            self.doctorPhoneLabel.text = r
            
        }
        
        
        
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
