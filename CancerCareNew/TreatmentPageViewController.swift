//
//  TreatmentPageViewController.swift
//  CancerCareNew
//
//  Created by Aykut on 17.12.2016.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase


class TreatmentPageViewController: UIViewController {
    var network = NetworkingService()
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)
    let database = DatabaseAdapter()
    var meds = "deneme"

    @IBOutlet weak var medsTextView: UITextView!
    @IBOutlet weak var addMedicineButton: UIButton!
    
    @IBAction func addMedicineButtonAction(_ sender: Any) {
        let nextViewController = storyboardRef.instantiateViewController(withIdentifier: "editTreatmentPage") as! EditTreatmentPageViewController
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "İlaçlarım"
        self.navigationItem.title = "İlaçlarım"
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        displayMedicines(){r in
            self.medsTextView.text = r
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMedicines(completion: @escaping (String)->Void) {
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        let currDateKey = network.getUserDate()
        var result = ""
        
        database.fetchDict(key: "\(currUserID!)", path: "medInfo/"){ resultt in
            for k in resultt {
                if (k.key == currDateKey){
                    result = "\(k.value)"
                }
            }
            completion(result)
        }
    }
    
    func addMed(name: String, dosage: String, frequency: String){
        displayMedicines(){r in
            self.meds = r
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
