//
//  HomePageViewController.swift
//  CancerCareNew
//
//  Created by SOS Z14-12 on 26/11/16.
//  Copyright © 2016 FED. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var moodSlider: UISlider!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var moodTextLabel: UILabel!
    @IBOutlet weak var saveMoodButton: UIButton!
    
    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    let networkingService = NetworkingService()
    let currUser = FIRAuth.auth()?.currentUser

    
    @IBOutlet weak var menuButton: UIButton!
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)

    
    @IBAction func saveMoodAction(_ sender: Any) {
        let moodToBeSaved = Int(moodSlider.value).description
        networkingService.updateMood(user: currUser!, mood: moodToBeSaved)
    }
    
    @IBAction func moodSliderChanged(_ sender: Any) {
        moodTextLabel.text = "Çocuğumun bugünkü durumu (10 üzerinden): " + Int(moodSlider.value).description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Ana Sayfa"
        self.navigationItem.title = self.navigationController?.title
        moodTextLabel.text = Int(moodSlider.value).description

        /*
        let currUser = FIRAuth.auth()?.currentUser
        let userID = currUser?.uid
        eventLabel.text = databaseRef.child("children").child(userID!).value(forKeyPath: "/events/event") as! String?
        //eventLabel.text =
        */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    @IBAction func menuButtonAction(_ sender: Any) {
        let nextTableViewController = storyboardRef.instantiateViewController(withIdentifier: "menuTablePage") as! MenuTableViewController
        self.present(nextTableViewController, animated: true)
        /*
        instantiateViewController(withIdentifier: "loginPage") as! LoginViewController
        */
        
        //self.present(nextViewController, animated: true)
    }
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
