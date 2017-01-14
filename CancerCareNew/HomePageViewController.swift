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
    let user = User()
    let organizer = OrganizerViewController()

    
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    let networkingService = NetworkingService()
    let currUser = FIRAuth.auth()?.currentUser
    var isAddEnabled = false
    var result = ""
    
    let database = DatabaseAdapter()
    

    
    @IBOutlet weak var menuButton: UIButton!
    var storyboardRef = UIStoryboard(name: "Main", bundle: nil)

    
    @IBAction func saveMoodAction(_ sender: Any) {
        if isAddEnabled {
            saveMoodButton.setTitle("Ekle", for: .normal)
            self.moodSlider.isHidden = true
            let moodToBeSaved = Int(moodSlider.value).description
            networkingService.updateMood(user: currUser!, mood: moodToBeSaved)
            moodTextLabel.text = moodToBeSaved
            isAddEnabled = false
        } else {
            saveMoodButton.setTitle("Kaydet", for: .normal)
            self.moodSlider.isHidden = false
            isAddEnabled = true
        }
    }
    
    @IBAction func moodSliderChanged(_ sender: Any) {
        let moodInt = Int(moodSlider.value)
        let moodString = moodInt.description
 
        if moodInt == 1 {
            moodSlider.tintColor = UIColor.blue
            moodTextLabel.text = moodString
        } else if moodInt == 2 {
            moodSlider.tintColor = UIColor.green
            moodTextLabel.text = moodString
        } else if moodInt == 3 {
            moodSlider.tintColor = UIColor.yellow
            moodTextLabel.text = moodString
        } else if moodInt == 4 {
            moodSlider.tintColor = UIColor.orange
            moodTextLabel.text = moodString
        } else {
            moodSlider.tintColor = UIColor.red
            moodTextLabel.text = moodString
        }
        // moodTextLabel.text = "Çocuğumun bugünkü durumu (10 üzerinden): " + Int(moodSlider.value).description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        self.navigationController?.title = "Ana Sayfa"
        self.navigationItem.title = self.navigationController?.title
        moodTextLabel.text = "Mood bilgisi yükleniyor...⌛️"
        // moodSlider stuff
        self.isAddEnabled = false
        self.saveMoodButton.setTitle("Ekle", for: .normal)
        self.moodSlider.isHidden = true
        eventLabel.text = "Etkinlik bilgisi yükleniyor..."
        
         displayCurrentMood(){r in
            self.moodTextLabel.text = r
        }
        
        displayCurrentEvent(){r in
            self.eventLabel.text = r
            //self.eventLabel.sizeToFit()
        }
        
        

    }

    func getCurrentDate() -> String {
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day
        ]
        let dateComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateComponents.year?.description
        let month = dateComponents.month?.description
        let day = dateComponents.day?.description
        var dateKey = ""
        dateKey += year!
        dateKey += month!
        dateKey += day!
        return dateKey
    }

    func getCurrentDateForEvent() -> String {
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day
        ]
        let dateComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateComponents.year?.description
        let month = dateComponents.month?.description
        let day = dateComponents.day?.description
        
        var newMonth = "0"
        if month == "1" || month == "2" || month == "3" || month == "4" || month == "5" || month == "6" || month == "7" || month == "8" || month == "9"{
            //var newMonth = "0"
            newMonth += month!
        }
        var newDay = "0"
        if day == "1" || day == "2" || day == "3" || day == "4" || day == "5" || day == "6" || day == "7" || day == "8" || day == "9"{
            //var newDay = "0"
            newDay += day!
        }

        
        var dateKey = ""
        dateKey += year!
        if month == "1" || month == "2" || month == "3" || month == "4" || month == "5" || month == "6" || month == "7" || month == "8" || month == "9"{
            dateKey += newMonth
        } else {
            dateKey += month!
        }
        if day == "1" || day == "2" || day == "3" || day == "4" || day == "5" || day == "6" || day == "7" || day == "8" || day == "9"{
            dateKey += newDay
        } else {
            dateKey += day!
        }
        
        return dateKey
    }

    
    
    func displayCurrentMood(completion: @escaping (String)->Void){
        
        let currDateKey = getCurrentDate()
        
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        
        var result = ""
        
        
        
        database.fetchDict(key: "\(currUserID!)", path: "moods/"){ resultt in
            
            
            
            for k in resultt {
                
                if (k.key == currDateKey){
                    
                    result = "Çocuğumun bugünkü mood'u \(k.value)"
                    
                }
                
            }
            
            completion(result)
            
        }
        
    }
    
    
    
    func displayCurrentEvent(completion: @escaping (String)->Void) {
        
        //let eventPath = "events/\(database.uid)"
        let currDateKey = getCurrentDateForEvent()
        let currUserID = FIRAuth.auth()?.currentUser?.uid
        var result = ""
        database.fetchDict(key: "\(currUserID!)", path: "events/"){ resultt in
            for k in resultt {
                if (k.key == currDateKey){
                    result = "Bugünkü etkinlik \(k.value)"
                }
            }
            completion(result)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func displayCurrMood(){
        let moodRef = databaseRef.child("moods")
        user.setCurrMood0(moodRef: moodRef, currUser: currUser!)
        moodTextLabel.text = ""
    }
    */
    
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
